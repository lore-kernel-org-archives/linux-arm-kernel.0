From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 7 Sep 2011 21:27:49 +0200
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <438BB0150E931F4B9CE701519A4463010871804A46@bgsmsx502.gar.corp.intel.com>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<438BB0150E931F4B9CE701519A4463010871804A46@bgsmsx502.gar.corp.intel.com>
Message-ID: <CAKnu2MrFMGUTn+DTKJaOmRALCadia8wSCKVTQVn6PPFAHuvayg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/7 Koul, Vinod <vinod.koul@intel.com>:
> On Tue, 2011-09-06 at 22:41 -0700, Barry Song wrote:
>
>> +config SIRF_DMA
>> + ? ? tristate "CSR SiRFprimaII DMA support"
>> + ? ? depends on ARCH_PRIMA2
>> + ? ? select DMA_ENGINE
>> + ? ? help
>> + ? ? ? Enable support for the CSR SiRFprimaII DMA engine.
>
> How different is it from the other primacell based DMA drivers, and why
> wouldn't it make sense to use/modify one of them?

Hehe it looks to me like primall has no relation to PrimeCell, just
confusingly similar names :-)

Yours,
Linus Walleij
