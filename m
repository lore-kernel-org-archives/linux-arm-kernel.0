From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Oct 2014 14:09:26 +0200
Subject: [PATCH v3 2/3] i2c: hix5hd2: add i2c controller driver
In-Reply-To: <1412079628-6316-3-git-send-email-zhangfei.gao@linaro.org>
References: <1412079628-6316-1-git-send-email-zhangfei.gao@linaro.org>
 <1412079628-6316-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20141003120926.GF1349@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 30, 2014 at 08:20:27PM +0800, Zhangfei Gao wrote:
> From: Wei Yan <sledge.yanwei@huawei.com>
> 
> I2C drivers for hix5hd2 soc series, including following chipset
> Hi3716CV200, Hi3719CV100, Hi3718CV100, Hi3719MV100, Hi3718MV100.
> 
> Signed-off-by: Wei Yan <sledge.yanwei@huawei.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Looks good to me. You probably want to have a look at this patch
http://patchwork.ozlabs.org/patch/394648/

an do something similar here, I guess.

BTW what tests have you performed?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141003/08e9a616/attachment-0001.sig>
