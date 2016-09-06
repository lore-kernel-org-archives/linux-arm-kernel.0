From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 6 Sep 2016 13:32:53 +0100
Subject: [PATCH v2 0/7] ARM: KVM: Support for vgic-v3
In-Reply-To: <20160905112853.GF26366@cbox>
References: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
 <20160905112853.GF26366@cbox>
Message-ID: <57CEB775.5060209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/16 12:28, Christoffer Dall wrote:
> On Tue, Aug 16, 2016 at 11:46:51AM +0100, Vladimir Murzin wrote:
>> Hi,
>>
>> This is an attempt to make use vgic-v3 under arch/arm since save-restore
>> functionality got re-written in C and can be shared between arm/arm64
>> like it has already been done for vgic-v2 and timer.
>>
>> With this patches I'm able to get 32 core ARMv7 guest boot:
> 
> Is it really an ARMv7 guest or an AArch32 ARMv8 guest?
> 

It is an AArch32 ARMv8 guest.

Vladimir
