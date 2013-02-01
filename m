From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Feb 2013 15:51:43 +0000
Subject: [GIT PULL 5/8] ARM: tegra: SCU base rework
In-Reply-To: <510B4892.3050900@wwwdotorg.org>
References: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
 <CAOesGMjjgz7Am7-D_fQHqgLX=G+Wc_LKL-GYMHd1-NzVC-DUfA@mail.gmail.com>
 <510B4892.3050900@wwwdotorg.org>
Message-ID: <201302011551.43947.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 February 2013, Stephen Warren wrote:
> Hmm. And here I was thinking that I was basing branches on top of
> each-other too much given your previous comments about merge conflicts
> being OK!

IMHO the cleanup branches are special in this regard because they
are primarily meant as a way to resolve the merge conflicts.
If you are able to put all the conflicts between the normal branches
into cleanup patches, you can put them all in one branch and
base your other branches on top of that. Of course that doesn't
always work, but it would solve this particular instance.

	Arnd
