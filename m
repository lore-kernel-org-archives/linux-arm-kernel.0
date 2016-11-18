From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Fri, 18 Nov 2016 01:48:47 +0100
Subject: [-next] i2c: digicolor: use clk_disable_unprepare instead of
 clk_unprepare
In-Reply-To: <1477758677-7831-1-git-send-email-weiyj.lk@gmail.com>
References: <1477758677-7831-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20161118004847.GA9905@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2016 at 04:31:17PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> since clk_prepare_enable() is used to get i2c->clk, we should
> use clk_disable_unprepare() to release it for the error path.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Acked-by: Baruch Siach <baruch@tkos.co.il>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161118/4c311fbd/attachment.sig>
