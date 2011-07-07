From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Jul 2011 10:50:58 +0200
Subject: [GIT PULL] i.MX cleanups
In-Reply-To: <20110707081424.GY6069@pengutronix.de>
References: <20110707081424.GY6069@pengutronix.de>
Message-ID: <201107071050.58303.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 July 2011 10:14:24 Sascha Hauer wrote:
> [once again with the list on Cc]
> 
> Please pull the following i.MX cleanup patches. This branch is directly
> based on the previous fixes pull request. I tried making this is
> independent on the fixes branch, but it resulted in merge conflicts.

I'll have a look later today and pull everything in.

As a general recommendation, simple merge conflicts are fine, I can handle
them. If you get a serious conflict, there are multiple ways of dealing
with it:

* create another branch that holds just the commits that cause the conflict,
  then base the other branches on top of that.

* base one branch on top of the other.  After the first one is upstream,
  the second one will only contain the changes it really wants.

In either way, this will result in increasing the number of pull requests
to stagger the merge upstream, so it's better not to need it.
The most important thing is to warn of any conflicts and dependencies so
I can deal with them.

	Arnd
