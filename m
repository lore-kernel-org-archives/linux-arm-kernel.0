From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Apr 2013 17:35:51 -0700
Subject: [GIT PULL] musb regression on omap4 for v3.9
In-Reply-To: <20130423214544.GN10155@atomide.com>
References: <20130423214544.GN10155@atomide.com>
Message-ID: <20130427003551.GB2350@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 02:45:45PM -0700, Tony Lindgren wrote:
> 
> The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:
> 
>   Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9-rc6/fixes-signed
> 
> for you to fetch changes up to f4d7a536faa43f30d87f701268db76b8433a2a8b:
> 
>   ARM: OMAP4: hwmod data: make 'ocp2scp_usb_phy_phy_48m" as the main clock (2013-04-10 13:26:07 -0700)
> 
> ----------------------------------------------------------------
> One MUSB regression fix that I forgot to send earlier. Without
> this MUSB no longer works on omap4 based devices.

Pulled into fixes. I'll send a pull request to Linus tonight, hopefully he
won't cut 3.9-final until later this weekend.


-Olof
