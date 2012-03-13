From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Mar 2012 12:09:51 +0000
Subject: [PATCH v4 02/11] ep93xx: Don't use system controller defines in
 audio drivers
In-Reply-To: <1331592502-9083-3-git-send-email-rmallon@gmail.com>
References: <1331592502-9083-3-git-send-email-rmallon@gmail.com>
Message-ID: <201203131209.52031.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 March 2012, Ryan Mallon wrote:
> This patch has already been applied in Mark's tree. It is posted
> for inclusion here because this series is against v3.3-rc7 and
> will cause build failures without it. There have been no changes
> to the patch since Mark applied it, so it should be okay to
> merge into both his tree and the arm-soc tree.

Ok, that should work. However, in the future when you anticipate
having to do something like this, I would suggest you do any patches
that you want to see applied to multiple branches as git-pull
requests, because that allows us to use the same changeset ids.

When we apply one patch separately to two branches, we end up
with multiple changesets in the git history, which is something
we normally try to avoid.

	Arnd
