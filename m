From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 14 Jun 2013 16:07:20 +0200
Subject: [PATCHv5 0/8] Add I2C support for Allwinner SoCs
In-Reply-To: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130614140719.GC2929@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 06:53:29PM +0200, Maxime Ripard wrote:
> Hi,
> 
> This patchset adds support for the I2C controller found on most of the
> Allwinner SoCs, especially the already supported A10 and A13, and the
> yet to come A31.
> 
> This driver leverages the Marvel mv64xxx i2c controller driver, that has
> an almost identical logic, with a slightly different register layout.

\o/ Yay, that's more like it. Thanks for the rework!

> It has been tested on a A13-Olinuxino and an A10s-Olinuxino.

I'd love to get some Tested-by or other tags for Marvell hardware. Any
volunteers?

> Changes from v4:
>   * Don't expose the reg offset structure through the platform data

Commit message 2/9 still speaks about pdata, but I will fix this locally
if all goes well with this series.

I will wait a bit more for tags and then pick up patches 1-3. I assume
the rest goes via arm-soc, let me know if I should take them.

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130614/94e58209/attachment-0001.sig>
