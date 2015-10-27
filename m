From: hs@denx.de (Heiko Schocher)
Date: Tue, 27 Oct 2015 13:33:42 +0100
Subject: [PATCH] regulator: tps65217: remove tps65217.dtsi file
In-Reply-To: <20151027122148.GA819@earth>
References: <1445850836-17863-1-git-send-email-hs@denx.de>
 <20151027122148.GA819@earth>
Message-ID: <562F6F26.4060005@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sebastian,

Am 27.10.2015 um 13:21 schrieb Sebastian Reichel:
> Hi,
>
> On Mon, Oct 26, 2015 at 10:13:55AM +0100, Heiko Schocher wrote:
>> remove tps65217.dtsi and adapt all boards, which
>> used it.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>> Suggested by Mark Brown, see:
>> https://lkml.org/lkml/2015/10/21/581
>>
>>   .../devicetree/bindings/regulator/tps65217.txt     | 78 ----------------------
>
> why did you delete the binding description?

Didn;t I sent a v2? I realized this after sending the v1 patch, and
prepared a v2, which does not remove this file ... Uh, yes, seems
I missed sending it ... Sorry. Send a v2 ASAP, thanks!

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
