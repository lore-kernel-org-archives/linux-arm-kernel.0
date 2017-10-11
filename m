From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 11 Oct 2017 17:11:49 +0200
Subject: [PATCH 09/12] ARM: dts: imx6-tx6: move display configuration to
 .dtsi file
In-Reply-To: <1507722635-30801-10-git-send-email-LW@KARO-electronics.de>
References: <1507722635-30801-1-git-send-email-LW@KARO-electronics.de>
 <1507722635-30801-10-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507734709.22082.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Wed, 2017-10-11 at 13:50 +0200, Lothar Wa?mann wrote:
> Currently the display (LCD or LVDS) configuration is duplicated with
> slight variations in each TX6 module specific file.
> 
> Move it to an include file for simplification and consistency.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

This is much appreciated,

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

This patch does conflict with Marco's?"ARM: dts: imx: Fix incorrect
display nodes notation" patch [1], which renames the display at di0 nodes
to disp0. Assuming it gets merged as-is, maybe rebase on top of that?

[1] https://patchwork.kernel.org/patch/9987341/

regards
Philipp
