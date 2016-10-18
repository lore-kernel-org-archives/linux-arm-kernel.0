From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 18 Oct 2016 11:42:39 +0100
Subject: [PATCH] ARM: dts: mps2: remove skeleton.dtsi include and fix unit
 address warnings
In-Reply-To: <8b698799-6c7a-d20a-6e54-ddd9eb329369@arm.com>
References: <1476704849-24039-1-git-send-email-vladimir.murzin@arm.com>
 <8b698799-6c7a-d20a-6e54-ddd9eb329369@arm.com>
Message-ID: <5805FC9F.8080809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/16 17:51, Sudeep Holla wrote:
> 
> 
> On 17/10/16 12:47, Vladimir Murzin wrote:
>> Removale of skeleton.dtsi allows us also to fix the following
>> warning from the dts compiler:
>>   Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>>
>> by adding proper unit addresses to the memory nodes.
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> 
> It's always better to cc device-tree list, anyways applied this to [1].

Thanks!

Vladimir

> 
> -- 
> Regards,
> Sudeep
> 
> [1] git.kernel.org/sudeep.holla/linux/h/vexpress-dt/for-next
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
