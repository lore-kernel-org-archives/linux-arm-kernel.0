From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 27 Jan 2013 14:17:54 +0800
Subject: [PATCH RESEND] ARM: dts: max77686: Add DTS file for max77686 PMIC
In-Reply-To: <CADoNuNeF_fw1uuMt89=gZm-A2R6FHGpr-kCgFkOY0xXpA9+Jzw@mail.gmail.com>
References: <1359053177-17725-1-git-send-email-tobetter@gmail.com>
 <20130126050618.GD10580@opensource.wolfsonmicro.com>
 <CADoNuNeF_fw1uuMt89=gZm-A2R6FHGpr-kCgFkOY0xXpA9+Jzw@mail.gmail.com>
Message-ID: <20130127061751.GF8952@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 03:06:53PM +0900, Dongjin Kim wrote:
> Hello Mark,
> 
> Yes, this is not ARM-specific chip at all. Just wanted to be reviewed
> by you and others if the format is ok before integrating to my board
> file. I had sent similar one before,
> https://patchwork.kernel.org/patch/1287711, and you advised that was
> too board specific. And plan to integrate like OMAP boards have with
> twl6030.dtsi and twl6040.dtsi.

> If would be nice if somewhere you specify a directory for such device files.

I think we need to create one, not quite sure where though.  drivers/of
perhaps but that's a bit non-idiomatic, or possibly something top level.
firmware might do too.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130127/6cbc0e71/attachment.sig>
