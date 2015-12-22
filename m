From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2015 12:53:00 +0000
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable GPU support
In-Reply-To: <1450788454.2637.17.camel@pengutronix.de>
References: <1450723442-1518-1-git-send-email-festevam@gmail.com>
 <20151222122154.GD26290@tiger>
 <CAOMZO5A8BEkNvrazmksRBRUQw+4mWwbfKtrK6KzD3XK5L5Fs7w@mail.gmail.com>
 <1450788454.2637.17.camel@pengutronix.de>
Message-ID: <20151222125300.GH8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 01:47:34PM +0100, Lucas Stach wrote:
> But to be honest I would like to give etnaviv a cycle to stabilize
> until we enable it by default. With i.MX6QP now hitting the street and
> basically no testing of etnaviv being done there until now, I would
> rather not have it in the defconfig just now. It's not like it's hard
> for people willing to test this to enable a single Kconfig option...

I already have an iMX6QP uSOM for the Hummingboard/Cubox-i, but I've
been holding back testing it because (from what I've seen of the QP
patches) I think it needs different settings for stuff like pinmux
and similar?

If the QP stuff gets into the kernel soon, I'll throw the uSOM onto
one of the many hummingboards I have here and add it into the etnaviv
test pool.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
