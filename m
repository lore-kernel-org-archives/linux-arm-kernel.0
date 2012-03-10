From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sat, 10 Mar 2012 10:55:04 +0100
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2
 tree
In-Reply-To: <20120308165116.d400947f35e40a923e9c6ad0@canb.auug.org.au>
References: <20120308165116.d400947f35e40a923e9c6ad0@canb.auug.org.au>
Message-ID: <1678557.FviZqEVemH@vclass>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 of March 2012 16:51:16 Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/mach-omap1/board-ams-delta.c between commit ddba6c7f7ec6
> ("OMAP1: pass LCD config with omapfb_set_lcd_config()") from the
> omap_dss2 tree and commits 5ca6180fa6d7 ("ARM: OMAP1: ams-delta:
> supersede custom led device by leds-gpio") and 2e3ee9f45b3c ("ARM: OMAP1:
> Move most of plat/io.h into local iomap.h") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.

Hi,
Your resolution looks good to me, thanks!
Janusz
