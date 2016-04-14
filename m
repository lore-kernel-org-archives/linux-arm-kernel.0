From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Apr 2016 09:57:07 +0100
Subject: [LINUX PATCH v2 1/3] spi: Added dummy_cycle entry in the
 spi_transfer structure.
In-Reply-To: <570F4F9F.3090605@atmel.com>
References: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
 <57067694.8030806@atmel.com>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C720DE@XAP-PVEXMBX02.xlnx.xilinx.com>
 <570F4F9F.3090605@atmel.com>
Message-ID: <20160414085707.GE18024@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 10:06:55AM +0200, Cyrille Pitchen wrote:

> I understand but you propose to patch both the SPI layer and the m25p80 driver
> to introduce some support which is already provided by the "spi_flash_read"
> hook: struct spi_flash_read_message has already a "dummy_bytes" field.
> IMHO, it looks redundant.

My understanding is that this is intended for dummy bits rather than
dummy bytes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160414/2ec0064a/attachment.sig>
