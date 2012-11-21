From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Nov 2012 23:21:08 -0800
Subject: [GIT PULL v2] Renesas ARM-based SoC boards for v3.8 #3
In-Reply-To: <1353372187-2903-1-git-send-email-horms@verge.net.au>
References: <1353372187-2903-1-git-send-email-horms@verge.net.au>
Message-ID: <20121121072108.GH7615@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 09:43:06AM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> Please consider the following board fix for 3.8.
> 
> The commit message for the patch has been revised since yesterday's
> pull-request.
> 
> Also, please let me know if you would prefer me to supply
> this as a fixes branch as we are now in the 3.7-rc6 timeframe
> where I understand that non-fix commits are no longer allowed for 3.8.
>
> This commit is based on the renesas/boards2 branch of the arm-soc tree.

It's not super-strictly "fixes only" at this point in the tree, but we really
want to make sure that we don't get any large pull requests from here on out.

For an update like this (adding one more patch on top of a previous branch),
this format is perfect since it allows us to just pull the same branch again,
really. So I've pulled this on top of the previous contents into next/boards2.


-Olof
