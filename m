From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Nov 2012 19:24:50 +0800
Subject: [PATCHv2] ARM: dts: cfa10049: Add PCA9555 GPIO expander to the
 device tree
In-Reply-To: <50AE023D.3000406@free-electrons.com>
References: <20121120144322.GE4882@S2100-06.ap.freescale.net>
 <1353422015-4790-1-git-send-email-maxime.ripard@free-electrons.com>
 <50AE023D.3000406@free-electrons.com>
Message-ID: <20121122112447.GI24693@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 11:45:17AM +0100, Maxime Ripard wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Shawn,
> 
> Le 20/11/2012 15:33, Maxime Ripard a ?crit :
> > Add the GPIO expander found on the i2c1 bus, behind the muxer to
> > the device tree.
> > 
> > This gpio expander will be used to get tachymeters values and data 
> > ready interruptions from the nuvoton NAU7802 ADCs.
> 
> If you're ok with it, I'd really like for that patch to be in 3.8.
> Is this version ok, or do you have any additional comments I could
> address?
> 
The patch is ok now.  But I have problem to apply it because its
prerequisite has been applied on i2c tree, as I did not plan a second
pull request for 3.8 at all.

I hope it's fine to apply the patch on top of v3.8-rc1, or you can
try to ask Wolfram to have this patch go via his tree too.

Shawn
