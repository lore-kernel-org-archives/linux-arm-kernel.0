From: broonie@kernel.org (Mark Brown)
Date: Thu, 25 Jul 2013 15:51:58 +0100
Subject: XCLKOUT in exynos5250 clock driver
Message-ID: <20130725145158.GI9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I appear to be missing something in the clock driver for the exynos5250.
I'm looking at the Arndale schematic and I see that the audio master
clock is connected to XCLKOUT on the SoC.  However I can't see any
reference to XCLKOUT or anything similar in the clock driver or any of
the DTS files - where is this clock exposed by the clock driver?

Unfortunately I haven't been able to get access to the datasheet for the
part so I can't check this myself.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/040fd358/attachment.sig>
