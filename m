From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Jun 2013 17:41:38 -0700
Subject: [GIT PULL 00/12] Renesas USB updates for v3.11
In-Reply-To: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106836-25388-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130615004138.GK18124@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 04:00:24PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> This pull request is based on a merge of renesas-soc-for-v3.11
> and renesas-pinmux-for-v3.11 in order to provide pre-requisites.
> You have previously pulled both of those tags.
> 
> I have put all of these patches into a single pull-request as
> R8A7779/Marzen clean-up portion are tightly related and don't seem
> to be easily broken out into e.g. board and soc components without
> introducing bisection breakage.
> 
> This pull request will cause various conflicts though I believe all
> of them are not difficult to resolve. The renesas-next-20130613 tag in
> my tree illustrates how I have handled the conflicts with
> both changes already in arm-soc and changes I intend to send
> pull requests for in the near future.
> 
> The following changes since commit ae8b378faea7f04d4517b22f5d70d824adcbc4dc:
> 
>   Merge branches 'heads/pinmux' and 'heads/soc' into phy-rcar-usb-base (2013-06-11 14:58:57 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-phy-rcar-usb-for-v3.11
> 
> for you to fetch changes up to 1a87b01d3b18709ae240ec90ae612354dd44d9a9:
> 
>   ARM: shmobile: BOCK-W: add USB support (2013-06-11 16:12:53 +0900)

Thanks, pulled. Quite annoying conflicts since I hit them twice, likely because
we had resolved the merge conflicts independenty.

Anyway, not a huge deal. It'd have been nice if the branch had been based on
the fix to the USB code that caused the whole move of code to be considered
a conflict, something to maybe consider next time.


-Olof
