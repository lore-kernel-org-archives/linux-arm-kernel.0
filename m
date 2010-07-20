From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Jul 2010 10:26:55 +0100
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 ,
	withRealView platform,board PBX-A9 and armv7 instructions.
In-Reply-To: <AANLkTik8QQPCOk_-zwrI4R2Kj_ROx3BAOOpFTMwXSjOD@mail.gmail.com>
References: <AANLkTikiHfOL0WMjiZnWY3RVmw89hZVFcNkqfDUYSDgG@mail.gmail.com>
	<1279542557.10760.21.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinPlxiyIV9rWAIc0CR_MTymXXqNLZAu-P8OvEHK@mail.gmail.com>
	<1279616037.27808.1.camel@e102109-lin.cambridge.arm.com>
	<AANLkTik8QQPCOk_-zwrI4R2Kj_ROx3BAOOpFTMwXSjOD@mail.gmail.com>
Message-ID: <1279618015.29006.17.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-20 at 17:22 +0800, David Yang wrote:
> eh...is it right that I need not use  wmb()  between two writel()?

It is right.

-- 
Catalin
