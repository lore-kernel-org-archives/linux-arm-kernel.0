From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Nov 2011 15:11:27 -0800
Subject: [GIT PULL] omap fixes for v3.2-rc2
In-Reply-To: <21329850.CZjvquqxJn@wuerfel>
References: <20111119194408.GD31337@atomide.com>
 <201111232115.41035.arnd@arndb.de>
 <20111123220358.GI31337@atomide.com> <21329850.CZjvquqxJn@wuerfel>
Message-ID: <20111123231127.GJ31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [111123 13:47]:
> On Wednesday 23 November 2011 14:03:58 Tony Lindgren wrote:
> > 
> > The earlier patches are based on the earlier fixes (while waiting
> > for them to get merged). So that's certainly not a random commit.
> > Or at least was not at that time  I can rebase those too anyways
> > now that the earlier fixes are merged.
> 
> No need to do that unless you are rebasing them anyway. IMHO
> it's fine if you have all your bug fixes in one branch based
> on the previous bug fixes you sent, but it's of course also
> fine to start a fresh branch for each pull request.
> 
> In general, I would recommend not rebasing when you have the
> choice, because that means your patches are not as well tested.

Well I can keep only four of them because of the pull on a random
commit. Looks like four of them apply to v3.1, will send them
off to stable at vger.kernel.org and send you two new pull requests.

Tony
