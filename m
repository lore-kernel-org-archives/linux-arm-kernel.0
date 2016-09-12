From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 12 Sep 2016 10:18:12 +0100
Subject: [PATCH v3 2/8] arm64: KVM: Move GIC accessors to arch_gicv3.h
In-Reply-To: <57D2E426.6000001@arm.com>
References: <1473350810-10857-1-git-send-email-vladimir.murzin@arm.com>
 <1473350810-10857-3-git-send-email-vladimir.murzin@arm.com>
 <57D2E426.6000001@arm.com>
Message-ID: <57D672D4.5020509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/16 17:32, Marc Zyngier wrote:
> On 08/09/16 17:06, Vladimir Murzin wrote:
>> Since we are going to share vgic-v3 save/restore code with ARM keep
>> arch specific accessors separately.
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 

Thanks!

Vladimir

> 	M.
> 
