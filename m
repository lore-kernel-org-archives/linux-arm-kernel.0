From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Sep 2017 09:11:00 -0700
Subject: next-20170926 build: 2 failures 1 warnings (next-20170926)
In-Reply-To: <E1dwn6w-0002eY-VE@optimist>
References: <E1dwn6w-0002eY-VE@optimist>
Message-ID: <20170926161100.nzyb33o6l6lad2da@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 11:29:06AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an arm and arm64 allmodconfig with:

> 	arm64-allmodconfig
> ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!
> 
> 	arm-allmodconfig
> ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!

caused by d8034e3379a83 (mmc: sdhci-msm: Utilize bulk clock API).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/cf8ce56b/attachment.sig>
