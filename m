From: shawn.gsc@gmail.com (Shawn Guo)
Date: Thu, 18 Nov 2010 09:56:20 +0800
Subject: [PATCH 00/51] some more imx patches for 2.6.38
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <AANLkTi=aPsqn4kj2OTJwOdRCyWUQ3md44MgrzEoGTecq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/11/18 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> Some of the patches in this series are already in Sascha's tree, I
> resend them because several of them got minor fixes.
>
> The highlights are that for most devices for i.MX1, i.MX21, i.MX25 and
> i.MX27 are allocated dynamically which reduces the memory footprint of
> the kernel. ?Moreover I moved support for i.MX25 to mach-imx targeting a
> multi-SoC-kernel for i.MX.
>
> Later I want to do the same for mx3. ?I'm not sure about mx5 though.
> The discussion about integrating support for i.MX28 into mach-imx made
> me questioning if this is sensible. ?Well, we'll see.
>
You are moving mach-mx25 into mach-imx, will do the same for mx3, and
thinking about the same for mx5. But you are asking me to move mx28
out of mach-imx.  This only makes sense for me if you think mx28 will
not go into mach-imx forever.  Are you sure about this? Otherwise we
are doing something really bothering ourselves.

-- 
Regards,
Shawn
