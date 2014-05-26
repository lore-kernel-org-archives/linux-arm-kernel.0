From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 26 May 2014 17:52:32 +0800
Subject: [PATCH] PCI: Turn pcibios_penalize_isa_irq() into __weak function
In-Reply-To: <4534160.Diq8cthzci@wuerfel>
References: <1399346992-6584-1-git-send-email-hanjun.guo@linaro.org>
 <4534160.Diq8cthzci@wuerfel>
Message-ID: <53830EE0.1070700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-5-6 15:26, Arnd Bergmann wrote:
> On Tuesday 06 May 2014 11:29:52 Hanjun Guo wrote:
>> pcibios_penalize_isa_irq() is only useful for x86 now, and
>> legacy ISA is not used by some architectures, so make
>> pcibios_penalize_isa_irq() as __weak function to simplify
>> the code, this will prevent new platform from introducing
>> dummy stub function for pcibios_penalize_isa_irq() too.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 

Hi Bjorn,

Any comments on this patch?

Thanks
Hanjun
