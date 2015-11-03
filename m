From: andreas.gruenbacher@gmail.com (=?UTF-8?Q?Andreas_Gr=C3=BCnbacher?=)
Date: Tue, 3 Nov 2015 16:54:33 +0100
Subject: [PATCH] xfs: only modify ACLs if CONFIG_XFS_POSIX_ACL enabled
In-Reply-To: <4425824.kIWhRaBxBZ@wuerfel>
References: <4425824.kIWhRaBxBZ@wuerfel>
Message-ID: <CAHpGcM+zgZbvuMMLT8FNGaBpHqy_u3X-9+yRcQqP0UTpvo1q7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2015-11-03 14:43 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
> A recent bug fix added a call to forget_cached_acl(), but that
> function is not always available, so we can get a build error
> here [...]

didn't expect anybody to trip over this anytime soon...

I've sent a fix yesterday,

  http://oss.sgi.com/archives/xfs/2015-11/msg00028.html

and Dave has already fixed it in for-next:

  git//git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git

Thanks,
Andreas
