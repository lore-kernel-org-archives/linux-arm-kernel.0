From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 28 Jul 2016 22:17:42 +0200
Subject: [PATCH -next] PCI: aardvark: Remove redundant dev_err call in
 advk_pcie_probe()
In-Reply-To: <1469722634-15049-1-git-send-email-weiyj.lk@gmail.com>
References: <1469722634-15049-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160728221742.403e558b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 28 Jul 2016 16:17:14 +0000, Wei Yongjun wrote:
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  drivers/pci/host/pci-aardvark.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
