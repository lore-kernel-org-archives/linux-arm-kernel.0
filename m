From: wenpan@hisilicon.com (wenpan)
Date: Wed, 16 Nov 2016 16:56:44 +0800
Subject: [PATCH 1/3] arm: hisi: add ARCH_MULTI_V5 support
In-Reply-To: <5893354.6MrIxqzRoI@wuerfel>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
 <20161017120705.3726-2-wenpan@hisilicon.com> <5893354.6MrIxqzRoI@wuerfel>
Message-ID: <e78a288b-8bab-9441-2edb-6ec08e5103d7@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martyo<

Does this confict with your patcho< If noto<
I hope this could be merged first.  Besides could you tell me the link to your related patch?

Thanks,
Pan

On 2016/10/17 21:48, Arnd Bergmann wrote:
> On Monday, October 17, 2016 8:07:03 PM CEST Pan Wen wrote:
>> Add support for some HiSilicon SoCs which depend on ARCH_MULTI_V5.
>>
>> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
>>
> 
> Looks ok. I've added Marty Plummer to Cc, he was recently proposing
> patches for Hi3520, which I think is closely related to this one.
> Please try to work together so the patches don't conflict. It should
> be fairly straightforward since you are basically doing the same
> change here.
> 
> 	Arnd
> 
> .
> 
