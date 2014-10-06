From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 6 Oct 2014 19:56:12 +0200
Subject: [PATCH v4 2/3] i2c: hix5hd2: add i2c controller driver
In-Reply-To: <1412350549-2607-3-git-send-email-zhangfei.gao@linaro.org>
References: <1412350549-2607-1-git-send-email-zhangfei.gao@linaro.org>
 <1412350549-2607-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20141006175611.GB2000@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 11:35:48PM +0800, Zhangfei Gao wrote:
> From: Wei Yan <sledge.yanwei@huawei.com>
> 
> I2C drivers for hix5hd2 soc series, including following chipset
> Hi3716CV200, Hi3719CV100, Hi3718CV100, Hi3719MV100, Hi3718MV100.
> 
> Signed-off-by: Wei Yan <sledge.yanwei@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Sorry, one more thing, then we are ready to go:

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

Here you say "GPL v2 or later"...

> +MODULE_LICENSE("GPL v2");

... here "GPL v2 only". That should be consistent!

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141006/1de41524/attachment.sig>
