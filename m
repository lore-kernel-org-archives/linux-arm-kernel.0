From: will.deacon@arm.com (Will Deacon)
Date: Tue, 3 Jul 2018 18:35:22 +0100
Subject: question about  : inv smmu  atc all cmd timeout when pcie dpc
 occur.
In-Reply-To: <8CD08B4737CACA4ABE0228F45E441A91638018B0@dggemm521-mbs.china.huawei.com>
References: <8CD08B4737CACA4ABE0228F45E441A91638018B0@dggemm521-mbs.china.huawei.com>
Message-ID: <20180703173522.GE27243@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhongmiao,

On Mon, Jul 02, 2018 at 02:24:45PM +0000, Zhongmiao wrote:
>       I?m testing  pcie  ats feature .     when some  error occur pcie dpc
>  then  link down .  iommu will   remove device from iommu group and send  atc
> inv all  cmd to  device .
> 
>  
> 
> But , pcie already  link down , so  atc inv all  will   time out .  I what to
> know kernel  driver  how to think aout it  ?  thanks .  ^_^.

Mainline doesn't do anything with ATC invalidate. Which tree are you using?

Will
