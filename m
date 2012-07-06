From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Jul 2012 20:31:01 +0000
Subject: [GIT PULL V2 0/7] ARM: tegra: pull requests for 3.6
In-Reply-To: <1341600482-11020-1-git-send-email-swarren@wwwdotorg.org>
References: <1341600482-11020-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201207062031.01998.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 July 2012, Stephen Warren wrote:
> This is Tegra's pull requests for v3.6.
> 
> Changes in V2:
> * Split for-3.6/{fixes,soc} to remove their dependency.
> * Split for-3.6/{dt,boards} to remove their dependency.
> * Added example merge resolution branches for the conflicts when merging
>   the above pairs of branches.

Pulled all of those, thanks for redoing the series so quickly!

I pulled both the fixes and the cleanup branch into the arm-soc next/cleanup
one, because I usually like the fixes to come even before the cleanups, but
I think that's fine.

The merge conflicts were really trivial compared to other things I'm used
to, so there is no need to provide an example merge in cases like this,
git mergetool handles those just fine.

I appreciate the comments for each pull request, I copied them into the
merge changeset description where it makes sense. This would be even easier
if you used signed tags because then you can put the text directly into
the tag message and I don't have to copy it.

Good job also on getting to the point where you can easily add support
for a new board using DT.

	Arnd
