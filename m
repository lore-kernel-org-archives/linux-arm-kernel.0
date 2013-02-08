From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 8 Feb 2013 13:17:05 +0000
Subject: [PATCH 3/4] spi: s3c64xx: add gpio quirk for controller
In-Reply-To: <CAKrE-KfrWdOxm+DJyWqZn1Ye509E_LjzmDb5FMq55SF9-Sua0A@mail.gmail.com>
References: <1360105784-12282-1-git-send-email-ks.giri@samsung.com>
 <1360105784-12282-4-git-send-email-ks.giri@samsung.com>
 <20130207115546.GA3801@sirena.org.uk>
 <CAKrE-KfrWdOxm+DJyWqZn1Ye509E_LjzmDb5FMq55SF9-Sua0A@mail.gmail.com>
Message-ID: <20130208131705.GZ8879@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 10:54:01AM -0800, Girish KS wrote:

> As suggested i would make two changes.
> 1. would parse the "gpios"  property and make decision whether to use
> gpios/dedicated pins for miso/miso/clk.
> 2.would parse "cs-gpio"  property from dts node to handle the chip select
> correct me if my understanding is wrong

I think that's probably OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130208/03d4eeab/attachment.sig>
