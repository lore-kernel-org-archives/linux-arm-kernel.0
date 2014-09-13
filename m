From: broonie@kernel.org (Mark Brown)
Date: Sat, 13 Sep 2014 17:06:28 +0100
Subject: [PATCH v3] spi: davinci: add support for adding delay between
 word's transmissions
In-Reply-To: <1410536892-22775-1-git-send-email-grygorii.strashko@ti.com>
References: <1410536892-22775-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140913160628.GF7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 06:48:12PM +0300, Grygorii Strashko wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
> 
> This patch adds ability to configure delay between transmission of
> words over SPI bus if it's required by SPI slave devices.

This is fine but it doesn't appear to apply against current code.  Can
you please check and resend?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/6cbdbbdd/attachment.sig>
