From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 29 Dec 2013 13:56:33 -0800
Subject: [PATCH 0/4] clk: sunxi: add A20 external output clock support
In-Reply-To: <20131229205927.GM3144@lukather>
References: <1387787827-11341-1-git-send-email-wens@csie.org>
 <20131229205927.GM3144@lukather>
Message-ID: <20131229215633.12054.22211@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2013-12-29 12:59:27)
> Hi Chen-Yu,
> 
> On Mon, Dec 23, 2013 at 04:37:02PM +0800, Chen-Yu Tsai wrote:
> > Hi everyone,
> > 
> > This patch series adds support for the Allwinner A20's 2 external clock
> > outputs. The CubieTruck uses one such output to supply a stable 32.768
> > KHz low power clock to its AP6210 WiFi module. Support for the module
> > is being added to brcmfmac (brcm80211) by Broadcom people.
> > 
> > The patches should be applied after Emilio's sunxi clock series, as it
> > uses the new factors clocks setup code.
> 
> Overall, it looks nice, but could you resend it as a separate thread,
> with [PATCHv2] as a prefix (git format-patch's --reroll-count can help
> you there) and CC'ing Linus Walleij for the pinctrl patch?

Hi Maxime,

Just FYI I have taken patch #1 of this series via Emilio's pull request.

Regards,
Mike

> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
