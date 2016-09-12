From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 12 Sep 2016 10:18:41 +0100
Subject: [PATCH v3 3/8] arm64: KVM: Move vgic-v3 save/restore to
 virt/kvm/arm/hyp
In-Reply-To: <57D2E448.304@arm.com>
References: <1473350810-10857-1-git-send-email-vladimir.murzin@arm.com>
 <1473350810-10857-4-git-send-email-vladimir.murzin@arm.com>
 <57D2E448.304@arm.com>
Message-ID: <57D672F1.7080902@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/16 17:33, Marc Zyngier wrote:
> On 08/09/16 17:06, Vladimir Murzin wrote:
>> So we can reuse the code under arch/arm
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 

Thanks!

Vladimir

> 	M.
> 
