From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 8 Sep 2011 09:47:18 +0800
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <CAKnu2MrFMGUTn+DTKJaOmRALCadia8wSCKVTQVn6PPFAHuvayg@mail.gmail.com>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<438BB0150E931F4B9CE701519A4463010871804A46@bgsmsx502.gar.corp.intel.com>
	<CAKnu2MrFMGUTn+DTKJaOmRALCadia8wSCKVTQVn6PPFAHuvayg@mail.gmail.com>
Message-ID: <CAGsJ_4wuFeLNPhQc5SsgfFXbNOq9N8hPaBNQX2ChZfgb=n6asw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/8 Linus Walleij <linus.ml.walleij@gmail.com>:
> 2011/9/7 Koul, Vinod <vinod.koul@intel.com>:
>> On Tue, 2011-09-06 at 22:41 -0700, Barry Song wrote:
>>
>>> +config SIRF_DMA
>>> + ? ? tristate "CSR SiRFprimaII DMA support"
>>> + ? ? depends on ARCH_PRIMA2
>>> + ? ? select DMA_ENGINE
>>> + ? ? help
>>> + ? ? ? Enable support for the CSR SiRFprimaII DMA engine.
>>
>> How different is it from the other primacell based DMA drivers, and why
>> wouldn't it make sense to use/modify one of them?
>
> Hehe it looks to me like primall has no relation to PrimeCell, just
> confusingly similar names :-)

yes. only with the word "prima", which is the mach name. it has
nothing to do with primecell.
>
> Yours,
> Linus Walleij
-barry
