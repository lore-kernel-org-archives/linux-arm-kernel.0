From: james.morse@arm.com (James Morse)
Date: Tue, 22 Sep 2015 16:19:15 +0100
Subject: [PATCH 00/22] arm64: Consolidate CPU feature handling
In-Reply-To: <55FBD7FB.2030800@arm.com>
References: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
 <55FBD7FB.2030800@arm.com>
Message-ID: <56017173.70508@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/09/15 10:23, Suzuki K. Poulose wrote:
> On 16/09/15 15:20, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> This is an updated reincarnation of my "arm64: Expose CPU feature registers"
>> series [1], which does much more.
> 
> 
> The series is also available here :
> 
> git://linux-arm.org/linux-skp.git cpu-ftr/v1-4.3-rc1

Hi Suzuki,

I gave your branch a spin on some insane combinations with a fast-model -
testing PAN only got enabled when all cores supported it.

Tested-by: James Morse <james.morse@arm.com>


Thanks,

James
