From: broonie@kernel.org (Mark Brown)
Date: Thu, 28 Sep 2017 12:00:20 -0700
Subject: next-20170926 build: 2 failures 1 warnings (next-20170926)
In-Reply-To: <20170926161100.nzyb33o6l6lad2da@sirena.org.uk>
References: <E1dwn6w-0002eY-VE@optimist>
 <20170926161100.nzyb33o6l6lad2da@sirena.org.uk>
Message-ID: <20170928190020.yyntjpmh5jebydsa@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 09:11:00AM -0700, Mark Brown wrote:
> On Tue, Sep 26, 2017 at 11:29:06AM +0100, Build bot for Mark Brown wrote:
> 
> Today's -next fails to build an arm and arm64 allmodconfig with:
> 
> > 	arm64-allmodconfig
> > ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!
> > 
> > 	arm-allmodconfig
> > ERROR: "clk_bulk_prepare" [drivers/mmc/host/sdhci-msm.ko] undefined!
> 
> caused by d8034e3379a83 (mmc: sdhci-msm: Utilize bulk clock API).

This is still present in today's -next.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170928/ff0be493/attachment.sig>
