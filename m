From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Sun, 25 Sep 2016 20:46:33 -0700
Subject: [PATCH -next] mmc: sdhci-of-arasan: Fix non static symbol warning
In-Reply-To: <1474818243-19207-1-git-send-email-weiyj.lk@gmail.com>
References: <1474818243-19207-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160926034633.GY16583@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-09-25 at 15:44:03 +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> drivers/mmc/host/sdhci-of-arasan.c:253:6: warning:
>  symbol 'sdhci_arasan_reset' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
