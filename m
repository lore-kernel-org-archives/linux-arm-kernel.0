From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Feb 2014 15:09:05 +0900
Subject: Linux-3.13.5/Samsung S3C6410/Mini6410: What does this warning
 mean?
In-Reply-To: <201402231202.06468.juergen@kreuzholzen.de>
References: <201402231202.06468.juergen@kreuzholzen.de>
Message-ID: <20140224060905.GD25940@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 12:02:06PM +0100, Juergen Beisert wrote:

> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:883 __clk_enable+0x24/0x9c()
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 3.13.5-ptx-master #9

> [<c0018e04>] (s3c_adc_probe+0x11c/0x194) from [<c0190ecc>] (platform_drv_probe+0x18/0x48)

> Any idea what is means?

The ADC driver needs to be converted to clk_prepare_enable().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140224/ee308b9a/attachment.sig>
