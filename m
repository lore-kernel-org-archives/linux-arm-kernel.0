From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Mon, 5 Dec 2016 10:03:16 +0800
Subject: [PATCH 1/3] arm: hisi: add ARCH_MULTI_V5 support
In-Reply-To: <5893354.6MrIxqzRoI@wuerfel>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
 <20161017120705.3726-2-wenpan@hisilicon.com> <5893354.6MrIxqzRoI@wuerfel>
Message-ID: <2fcf5a5f-8935-c4f0-a034-c8a72dc2be0f@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

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
Marty hasn't give any replies about this thread until now. I reviewed
the patch for Hi3520. And I think this patch won't conflict with Hi3520.
Could you help us to ack this patch?

Thanks,
Jiancheng
