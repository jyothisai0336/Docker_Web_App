Here's the fully updated JSP with all three improvements applied:

```jsp
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="username" value="${pageContext.request.userPrincipal.name}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DevOps Network – ${username}</title>

    <!-- Bootstrap 4 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Font Awesome 5 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* ── Base ── */
        *, *::before, *::after { box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background: #f0f2f5;
            color: #1c1e21;
            padding-top: 60px;
        }

        a { color: #1877f2; text-decoration: none; }
        a:hover { text-decoration: underline; }

        /* ── Navbar ── */
        .navbar {
            background: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,.08);
            padding: 0 1.5rem;
            height: 60px;
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.3rem;
            color: #1877f2 !important;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .navbar-brand img { width: 32px; height: 32px; border-radius: 6px; }

        .nav-link {
            color: #606770 !important;
            font-weight: 500;
            padding: .4rem .8rem !important;
            border-radius: 8px;
            transition: background .15s;
        }
        .nav-link:hover { background: #f0f2f5; color: #1877f2 !important; text-decoration: none; }

        .nav-badge {
            position: relative;
            display: inline-flex;
            align-items: center;
        }
        .nav-badge .badge-dot {
            position: absolute;
            top: -4px; right: -4px;
            background: #e41e3f;
            color: #fff;
            font-size: .6rem;
            border-radius: 50%;
            width: 16px; height: 16px;
            display: flex; align-items: center; justify-content: center;
            border: 2px solid #fff;
        }

        /* User menu */
        .user-menu-toggle {
            display: flex; align-items: center; gap: 8px;
            background: none; border: none; cursor: pointer;
            padding: .25rem .5rem;
            border-radius: 8px;
            transition: background .15s;
        }
        .user-menu-toggle:hover { background: #f0f2f5; }
        .user-menu-toggle img { width: 36px; height: 36px; border-radius: 50%; object-fit: cover; }
        .user-menu-toggle span { font-weight: 600; font-size: .9rem; color: #1c1e21; }

        .user-dropdown {
            min-width: 280px;
            border: none;
            box-shadow: 0 8px 24px rgba(0,0,0,.15);
            border-radius: 12px;
            padding: 0;
            overflow: hidden;
        }
        .user-dropdown-header {
            padding: 1rem;
            border-bottom: 1px solid #e4e6eb;
            display: flex; align-items: center; gap: 12px;
        }
        .user-dropdown-header img { width: 56px; height: 56px; border-radius: 50%; object-fit: cover; }
        .user-dropdown-header .info .name { font-weight: 700; font-size: 1rem; color: #1c1e21; }
        .user-dropdown-header .info .email { font-size: .8rem; color: #606770; }

        .user-dropdown-body { padding: .5rem; }
        .user-dropdown-body .dropdown-item {
            border-radius: 8px;
            padding: .5rem .75rem;
            font-size: .875rem;
            color: #1c1e21;
            display: flex; align-items: center; gap: 10px;
        }
        .user-dropdown-body .dropdown-item i { width: 20px; text-align: center; color: #606770; }
        .user-dropdown-body .dropdown-item:hover { background: #f0f2f5; }
        .user-dropdown-body .dropdown-item.text-danger i { color: #e41e3f; }

        /* ── Layout ── */
        .main-layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 1.5rem;
            max-width: 1100px;
            margin: 0 auto;
            padding: 1.5rem 1rem;
        }

        @media (max-width: 768px) {
            .main-layout { grid-template-columns: 1fr; }
            .sidebar { display: none; }
        }

        /* ── Sidebar ── */
        .sidebar { position: sticky; top: 72px; align-self: start; }

        .profile-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 1px 4px rgba(0,0,0,.08);
            overflow: hidden;
        }
        .profile-card-cover {
            height: 90px;
            background: linear-gradient(135deg, #1877f2, #42b72a);
        }
        .profile-card-body { padding: 0 1.25rem 1.25rem; text-align: center; }
        .profile-card-body .avatar-wrap {
            margin-top: -36px;
            display: inline-block;
        }
        .profile-card-body .avatar-wrap img {
            width: 72px; height: 72px;
            border-radius: 50%;
            border: 3px solid #fff;
            object-fit: cover;
            box-shadow: 0 2px 8px rgba(0,0,0,.15);
        }
        .profile-card-body .profile-name {
            font-weight: 700;
            font-size: 1.1rem;
            margin-top: .5rem;
            color: #1c1e21;
        }
        .profile-card-body .profile-email {
            font-size: .8rem;
            color: #606770;
            margin-bottom: .75rem;
        }
        .profile-card-body .btn-update {
            background: #e7f0fd;
            color: #1877f2;
            border: none;
            border-radius: 8px;
            padding: .4rem 1rem;
            font-weight: 600;
            font-size: .875rem;
            width: 100%;
            transition: background .15s;
        }
        .profile-card-body .btn-update:hover { background: #d0e4fc; }

        .profile-meta {
            margin-top: 1rem;
            border-top: 1px solid #e4e6eb;
            padding-top: 1rem;
        }
        .profile-meta .meta-item {
            display: flex; align-items: flex-start; gap: 10px;
            margin-bottom: .75rem;
            font-size: .875rem;
        }
        .profile-meta .meta-item i {
            width: 20px; text-align: center;
            color: #606770; margin-top: 2px;
        }
        .profile-meta .meta-item .label {
            font-weight: 600;
            color: #1c1e21;
            font-size: .75rem;
            text-transform: uppercase;
            letter-spacing: .04em;
            display: block;
        }
        .profile-meta .meta-item .value { color: #606770; }

        /* Admin Links */
        .admin-panel {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 1px 4px rgba(0,0,0,.08);
            padding: 1rem 1.25rem;
            margin-top: 1rem;
        }
        .admin-panel h6 {
            font-weight: 700;
            font-size: .75rem;
            text-transform: uppercase;
            letter-spacing: .06em;
            color: #606770;
            margin-bottom: .75rem;
        }
        .admin-panel .btn-admin {
            display: flex; align-items: center; gap: 8px;
            background: #f0f2f5;
            border: none; border-radius: 8px;
            padding: .4rem .75rem;
            font-size: .875rem;
            font-weight: 500;
            color: #1c1e21;
            width: 100%; margin-bottom: .5rem;
            transition: background .15s;
        }
        .admin-panel .btn-admin:hover { background: #e4e6eb; text-decoration: none; }
        .admin-panel .btn-admin i { color: #1877f2; }

        /* ── Feed ── */
        .feed { min-width: 0; }

        /* Profile strip */
        .profile-strip {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 1px 4px rgba(0,0,0,.08);
            padding: 1.25rem 1.5rem;
            margin-bottom: 1.25rem;
        }
        .profile-strip .strip-header {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: .75rem;
        }
        .profile-strip .strip-header .name-group .display-name {
            font-weight: 700; font-size: 1.25rem;
        }
        .profile-strip .strip-header .name-group .email-sub {
            font-size: .85rem; color: #606770;
        }
        .profile-strip .tags { margin-bottom: .75rem; }
        .profile-strip .tag {
            display: inline-block;
            background: #e7f0fd;
            color: #1877f2;
            border-radius: 20px;
            padding: .15rem .75rem;
            font-size: .8rem;
            font-weight: 500;
            margin: .2rem .2rem 0 0;
            transition: background .15s;
        }
        .profile-strip .tag:hover { background: #d0e4fc; text-decoration: none; }
        .profile-strip .strip-nav {
            border-top: 1px solid #e4e6eb;
            padding-top: .75rem;
            display: flex; gap: .5rem; flex-wrap: wrap;
        }
        .profile-strip .strip-nav .nav-btn {
            color: #606770;
            border: none; background: none;
            border-radius: 8px;
            padding: .35rem .75rem;
            font-weight: 500;
            font-size: .875rem;
            transition: background .15s, color .15s;
            display: flex; align-items: center; gap: 6px;
        }
        .profile-strip .strip-nav .nav-btn:hover,
        .profile-strip .strip-nav .nav-btn.active {
            background: #e7f0fd; color: #1877f2;
        }
        .profile-strip .strip-nav .badge-count {
            background: #e41e3f; color: #fff;
            border-radius: 10px; padding: .1rem .45rem;
            font-size: .7rem;
        }

        /* Loading spinner */
        #posts-spinner {
            text-align: center;
            padding: 2rem;
            color: #606770;
        }

        /* Post card */
        .post-card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 1px 4px rgba(0,0,0,.08);
            margin-bottom: 1.25rem;
            overflow: hidden;
            transition: box-shadow .2s;
        }
        .post-card:hover { box-shadow: 0 4px 16px rgba(0,0,0,.12); }

        .post-card .post-header {
            display: flex; align-items: center; justify-content: space-between;
            padding: 1rem 1.25rem .5rem;
        }
        .post-card .post-header .author { display: flex; align-items: center; gap: 10px; }
        .post-card .post-header .author img {
            width: 44px; height: 44px;
            border-radius: 50%; object-fit: cover;
        }
        .post-card .post-header .author .author-name {
            font-weight: 600; font-size: .95rem; color: #1c1e21;
            display: block;
        }
        .post-card .post-header .author .post-meta {
            font-size: .78rem; color: #606770;
            display: flex; align-items: center; gap: 4px;
        }
        .post-card .post-header .author .post-meta .visibility-badge {
            background: #f0f2f5;
            border-radius: 4px;
            padding: .05rem .35rem;
            font-size: .72rem;
        }

        .post-options-btn {
            background: none; border: none;
            width: 36px; height: 36px;
            border-radius: 50%;
            color: #606770;
            font-size: 1rem;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; transition: background .15s;
        }
        .post-options-btn:hover { background: #f0f2f5; }

        .post-card .post-body { padding: .5rem 1.25rem 1rem; }
        .post-card .post-body p { margin-bottom: .6rem; line-height: 1.6; }
        .post-card .post-body img.post-img {
            width: 100%; border-radius: 12px;
            margin-top: .5rem;
        }

        /* Reshared inner card */
        .reshare-inner {
            border: 1px solid #e4e6eb;
            border-radius: 12px;
            padding: 1rem;
            margin-top: .5rem;
            background: #f9fafb;
        }
        .reshare-inner .reshare-author {
            display: flex; align-items: center; gap: 8px;
            margin-bottom: .75rem;
        }
        .reshare-inner .reshare-author img {
            width: 36px; height: 36px;
            border-radius: 50%; object-fit: cover;
        }
        .reshare-inner .reshare-author .name { font-weight: 600; font-size: .875rem; }
        .reshare-inner .reshare-author .time { font-size: .75rem; color: #606770; }

        /* Post actions */
        .post-actions {
            border-top: 1px solid #e4e6eb;
            display: flex; padding: .25rem .75rem;
        }
        .post-actions .action-btn {
            flex: 1;
            background: none; border: none;
            color: #606770;
            font-weight: 500;
            font-size: .875rem;
            padding: .5rem;
            border-radius: 8px;
            cursor: pointer;
            transition: background .15s, color .15s;
            display: flex; align-items: center; justify-content: center; gap: 6px;
        }
        .post-actions .action-btn:hover { background: #f0f2f5; color: #1877f2; }
        .post-actions .action-btn.liked { color: #e41e3f; }

        /* Comments */
        .comments-section { padding: .5rem 1.25rem 1rem; border-top: 1px solid #e4e6eb; }
        .comment-item {
            display: flex; gap: 10px;
            margin-bottom: .75rem;
        }
        .comment-item img {
            width: 32px; height: 32px;
            border-radius: 50%; object-fit: cover; flex-shrink: 0;
        }
        .comment-item .comment-bubble {
            background: #f0f2f5;
            border-radius: 12px;
            padding: .5rem .75rem;
            flex: 1;
        }
        .comment-item .comment-bubble .commenter-name {
            font-weight: 600; font-size: .82rem;
        }
        .comment-item .comment-bubble .comment-text {
            font-size: .875rem; margin-top: .15rem; line-height: 1.5;
        }
        .comment-item .comment-bubble .comment-time {
            font-size: .72rem; color: #606770; margin-top: .25rem;
        }
        .show-more-comments {
            background: none; border: none;
            color: #606770; font-size: .82rem;
            font-weight: 600; cursor: pointer;
            padding: 0; margin-bottom: .75rem;
            display: flex; align-items: center; gap: 4px;
        }
        .show-more-comments:hover { color: #1877f2; }

        .comment-input-row {
            display: flex; align-items: center; gap: 8px;
            padding: .5rem 1.25rem 1rem;
        }
        .comment-input-row img {
            width: 32px; height: 32px;
            border-radius: 50%; object-fit: cover; flex-shrink: 0;
        }
        .comment-input-row input {
            flex: 1;
            background: #f0f2f5;
            border: none; border-radius: 20px;
            padding: .5rem 1rem;
            font-size: .875rem;
            outline: none;
            transition: background .15s;
        }
        .comment-input-row input:focus { background: #e4e6eb; }

        /* Empty / error state */
        .feed-empty {
            background: #fff;
            border-radius: 16px;
            padding: 3rem;
            text-align: center;
            color: #606770;
            box-shadow: 0 1px 4px rgba(0,0,0,.08);
        }
        .feed-empty i { font-size: 2.5rem; margin-bottom: 1rem; color: #bcc0c4; }

        /* Dropdown menus */
        .dropdown-menu { border: none; box-shadow: 0 8px 24px rgba(0,0,0,.15); border-radius: 12px; padding: .5rem; }
        .dropdown-item { border-radius: 8px; font-size: .875rem; padding: .5rem .75rem; }
        .dropdown-item:hover { background: #f0f2f5; }
        .dropdown-item.text-danger:hover { background: #fdecea; }
    </style>
</head>
<body>

<!-- ══════════════════════════════════════════════
     NAVBAR
     ══════════════════════════════════════════════ -->
<nav class="navbar navbar-expand-md fixed-top">
    <a class="navbar-brand" href="#">
        <img src="${contextPath}/resources/Images/user/logo.png" alt="DevOps Logo">
        DevOps
        <small class="text-muted" style="font-weight:400; font-size:.65rem; margin-left:4px;">VP* Network</small>
    </a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#mainNav">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="mainNav">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item"><a class="nav-link" href="${contextPath}/ORqmj"><i class="fas fa-stream mr-1"></i>Stream</a></li>
            <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-bolt mr-1"></i>My Activity</a></li>
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <span class="nav-badge">
                        <i class="far fa-bell fa-lg"></i>
                        <span class="badge-dot">2</span>
                    </span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"><i class="far fa-envelope fa-lg"></i></a>
            </li>
        </ul>

        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <button class="user-menu-toggle dropdown-toggle" data-toggle="dropdown">
                    <img src="${contextPath}/resources/Images/user/user.png" alt="${username}">
                    <span>${username}</span>
                </button>
                <div class="dropdown-menu dropdown-menu-right user-dropdown">
                    <div class="user-dropdown-header">
                        <img src="${contextPath}/resources/Images/user/user.png" alt="${username}">
                        <div class="info">
                            <div class="name">${username}</div>
                            <div class="email">${username}@devops.co.in</div>
                        </div>
                    </div>
                    <div class="user-dropdown-body">
                        <a href="${contextPath}/user/${username}" class="dropdown-item">
                            <i class="fas fa-user-circle"></i> Update Profile
                        </a>
                        <a href="${contextPath}/upload" class="dropdown-item">
                            <i class="fas fa-camera"></i> Change Photo
                        </a>
                        <a href="#" class="dropdown-item">
                            <i class="fas fa-address-book"></i> Contacts
                        </a>
                        <a href="#" class="dropdown-item">
                            <i class="fas fa-cog"></i> Settings
                        </a>
                        <a href="#" class="dropdown-item">
                            <i class="fas fa-lock"></i> Change Password
                        </a>
                        <div class="dropdown-divider"></div>
                        <a onclick="document.forms['logoutForm'].submit()" class="dropdown-item text-danger" href="#">
                            <i class="fas fa-sign-out-alt"></i> Sign Out
                        </a>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</nav>

<!-- ══════════════════════════════════════════════
     MAIN LAYOUT
     ══════════════════════════════════════════════ -->
<div class="main-layout">

    <!-- ── SIDEBAR ── -->
    <aside class="sidebar">

        <!-- Profile card: data pulled from userProfile model attribute -->
        <div class="profile-card">
            <div class="profile-card-cover"></div>
            <div class="profile-card-body">
                <div class="avatar-wrap">
                    <img src="${not empty userProfile.photoUrl ? userProfile.photoUrl : contextPath.concat('/resources/Images/user/user.png')}"
                         alt="${username}">
                </div>
                <div class="profile-name">${username}</div>
                <div class="profile-email">${username}@devops.co.in</div>
                <a href="${contextPath}/user/${username}" class="btn-update">Edit Profile</a>

                <div class="profile-meta">
                    <div class="meta-item">
                        <i class="fas fa-align-left"></i>
                        <div>
                            <span class="label">Bio</span>
                            <span class="value">
                                <c:choose>
                                    <c:when test="${not empty userProfile.bio}">${userProfile.bio}</c:when>
                                    <c:otherwise>No bio yet.</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <div>
                            <span class="label">Location</span>
                            <span class="value">
                                <c:choose>
                                    <c:when test="${not empty userProfile.location}">${userProfile.location}</c:when>
                                    <c:otherwise>Not specified</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-venus-mars"></i>
                        <div>
                            <span class="label">Gender</span>
                            <span class="value">
                                <c:choose>
                                    <c:when test="${not empty userProfile.gender}">${userProfile.gender}</c:when>
                                    <c:otherwise>Not specified</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                    <div class="meta-item">
                        <i class="fas fa-birthday-cake"></i>
                        <div>
                            <span class="label">Birthday</span>
                            <span class="value">
                                <c:choose>
                                    <c:when test="${not empty userProfile.birthday}">
                                        <fmt:formatDate value="${userProfile.birthday}" pattern="MMMM dd, yyyy"/>
                                    </c:when>
                                    <c:otherwise>Not specified</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Admin panel (only for admin_vp) -->
        <c:if test="${username == 'admin_vp'}">
            <div class="admin-panel">
                <h6><i class="fas fa-shield-alt mr-1"></i>Admin</h6>
                <a href="${contextPath}/users" class="btn-admin">
                    <i class="fas fa-users"></i> All Users
                </a>
                <a href="${contextPath}/user/rabbit" class="btn-admin">
                    <i class="fas fa-exchange-alt"></i> RabbitMQ
                </a>
                <a href="${contextPath}/user/elasticsearch" class="btn-admin">
                    <i class="fas fa-search"></i> Elasticsearch
                </a>
            </div>
        </c:if>

    </aside>

    <!-- ── FEED ── -->
    <main class="feed">

        <!-- Profile strip -->
        <div class="profile-strip">
            <div class="strip-header">
                <div class="name-group">
                    <span class="display-name">${username}</span>
                    <span class="email-sub">${username}@devops.co.in
                        <i class="fas fa-check-circle text-success ml-1" title="Verified"></i>
                    </span>
                </div>
                <div class="dropdown">
                    <button class="btn btn-sm btn-primary dropdown-toggle" data-toggle="dropdown">
                        <i class="fas fa-user-friends mr-1"></i>Friends
                    </button>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-item" href="#"><i class="fas fa-fw fa-home mr-2"></i>Family</a>
                        <a class="dropdown-item active" href="#"><i class="fas fa-fw fa-check mr-2"></i>Friends</a>
                        <a class="dropdown-item" href="#"><i class="fas fa-fw fa-briefcase mr-2"></i>Work</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#"><i class="fas fa-fw fa-plus mr-2"></i>Add a new aspect</a>
                    </div>
                </div>
            </div>

            <div class="tags">
                <a href="#" class="tag">#DevOps</a>
                <a href="#" class="tag">#ContinuousIntegration</a>
                <a href="#" class="tag">#ContinuousDelivery</a>
                <a href="#" class="tag">#Automation</a>
            </div>

            <div class="strip-nav">
                <button class="nav-btn active"><i class="fas fa-file-alt"></i>Posts</button>
                <button class="nav-btn">
                    <i class="fas fa-images"></i>Photos
                    <span class="badge-count">${not empty photoCount ? photoCount : 0}</span>
                </button>
                <button class="nav-btn">
                    <i class="fas fa-users"></i>Contacts
                    <span class="badge-count">${not empty contactCount ? contactCount : 0}</span>
                </button>
            </div>
        </div>

        <!-- ════════════════════════════════════════
             DYNAMIC POSTS — rendered server-side
             from the `posts` model attribute.

             Backend expectation:
               Model attribute: List<Post> posts
               Post fields:
                 id, authorName, authorPhotoUrl,
                 createdAt (java.util.Date),
                 visibility (PUBLIC/LIMITED),
                 content, imageUrl,
                 isReshare (boolean), originalPost (Post),
                 comments (List<Comment>),
                 likeCount, reshareCount
             ════════════════════════════════════════ -->

        <c:choose>
            <c:when test="${empty posts}">
                <div class="feed-empty">
                    <i class="far fa-newspaper d-block"></i>
                    <strong>No posts yet</strong>
                    <p class="mt-2 mb-0">When you or your contacts post something, it will appear here.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="post" items="${posts}" varStatus="loop">
                    <div class="post-card" id="post-${post.id}">

                        <!-- Post header -->
                        <div class="post-header">
                            <div class="author">
                                <img src="${not empty post.authorPhotoUrl ? post.authorPhotoUrl : contextPath.concat('/resources/Images/user/user.png')}"
                                     alt="${post.authorName}">
                                <div>
                                    <a class="author-name" href="#">${post.authorName}</a>
                                    <span class="post-meta">
                                        <i class="far fa-clock"></i>
                                        <fmt:formatDate value="${post.createdAt}" pattern="MMM d 'at' h:mm a"/>
                                        <span class="visibility-badge ml-1">
                                            <c:choose>
                                                <c:when test="${post.visibility == 'PUBLIC'}">
                                                    <i class="fas fa-globe-americas"></i> Public
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-user-lock"></i> Limited
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </span>
                                </div>
                            </div>

                            <!-- Post options dropdown — unique ID per post -->
                            <div class="dropdown">
                                <button class="post-options-btn" id="postOpts-${post.id}" data-toggle="dropdown">
                                    <i class="fas fa-ellipsis-h"></i>
                                </button>
                                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="postOpts-${post.id}">
                                    <a class="dropdown-item" href="#"><i class="fas fa-fw fa-exclamation-triangle mr-2 text-warning"></i>Report</a>
                                    <a class="dropdown-item" href="#"><i class="fas fa-fw fa-ban mr-2"></i>Ignore</a>
                                    <a class="dropdown-item" href="#"><i class="fas fa-fw fa-bell mr-2"></i>Enable notifications</a>
                                    <a class="dropdown-item" href="#"><i class="fas fa-fw fa-eye-slash mr-2"></i>Hide</a>
                                    <c:if test="${post.authorName == username}">
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item text-danger" href="${contextPath}/posts/${post.id}/delete">
                                            <i class="fas fa-fw fa-trash mr-2"></i>Delete
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Post body -->
                        <div class="post-body">
                            <!-- Reshared post -->
                            <c:if test="${post.isReshare and not empty post.originalPost}">
                                <p class="text-muted" style="font-size:.85rem;">
                                    <i class="fas fa-retweet mr-1"></i>reshared a post
                                </p>
                                <div class="reshare-inner">
                                    <div class="reshare-author">
                                        <img src="${not empty post.originalPost.authorPhotoUrl ? post.originalPost.authorPhotoUrl : contextPath.concat('/resources/Images/user/user.png')}"
                                             alt="${post.originalPost.authorName}">
                                        <div>
                                            <span class="name">${post.originalPost.authorName}</span>
                                            <span class="time d-block">
                                                <fmt:formatDate value="${post.originalPost.createdAt}" pattern="MMM d 'at' h:mm a"/>
                                            </span>
                                        </div>
                                    </div>
                                    <p>${post.originalPost.content}</p>
                                </div>
                            </c:if>

                            <!-- Regular content -->
                            <c:if test="${not empty post.content}">
                                <p>${post.content}</p>
                            </c:if>

                            <!-- Image attachment -->
                            <c:if test="${not empty post.imageUrl}">
                                <img class="post-img" src="${post.imageUrl}" alt="Post image">
                            </c:if>
                        </div>

                        <!-- Like / Reshare / Comment actions -->
                        <div class="post-actions">
                            <button class="action-btn like-btn" data-post-id="${post.id}">
                                <i class="far fa-heart"></i>
                                <span>${not empty post.likeCount ? post.likeCount : ''} Like</span>
                            </button>
                            <button class="action-btn">
                                <i class="fas fa-retweet"></i>
                                <span>${not empty post.reshareCount ? post.reshareCount : ''} Reshare</span>
                            </button>
                            <button class="action-btn toggle-comments-btn" data-target="comments-${post.id}">
                                <i class="far fa-comment"></i>
                                <span>Comment</span>
                            </button>
                        </div>

                        <!-- Comments -->
                        <c:if test="${not empty post.comments}">
                            <div class="comments-section" id="comments-${post.id}">
                                <c:if test="${fn:length(post.comments) > 2}">
                                    <button class="show-more-comments"
                                            data-post-id="${post.id}"
                                            data-total="${fn:length(post.comments)}">
                                        <i class="fas fa-bars"></i>
                                        Show ${fn:length(post.comments) - 2} more comments
                                    </button>
                                </c:if>

                                <c:forEach var="comment" items="${post.comments}" varStatus="cs">
                                    <div class="comment-item ${cs.index < fn:length(post.comments) - 2 ? 'comment-hidden' : ''}"
                                         style="${cs.index < fn:length(post.comments) - 2 ? 'display:none;' : ''}">
                                        <img src="${not empty comment.authorPhotoUrl ? comment.authorPhotoUrl : contextPath.concat('/resources/Images/user/user.png')}"
                                             alt="${comment.authorName}">
                                        <div class="comment-bubble">
                                            <span class="commenter-name">${comment.authorName}</span>
                                            <p class="comment-text">${comment.content}</p>
                                            <span class="comment-time">
                                                <i class="far fa-clock"></i>
                                                <fmt:formatDate value="${comment.createdAt}" pattern="MMM d 'at' h:mm a"/>
                                            </span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>

                        <!-- Comment input -->
                        <div class="comment-input-row">
                            <img src="${context
