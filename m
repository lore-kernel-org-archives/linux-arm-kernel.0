From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 21 Mar 2012 10:15:49 -0600
Subject: [PATCH] ARM: tegra: Include assembler.h in sleep.S to fix build
 break
In-Reply-To: <4F677691.8020307@gmail.com>
References: <1332176863-12537-1-git-send-email-swarren@wwwdotorg.org>
 <4F677691.8020307@gmail.com>
Message-ID: <4F69FEB5.2020901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2012 12:10 PM, Rob Herring wrote:
> On 03/19/2012 12:07 PM, Stephen Warren wrote:
>> Commit 6f6f6a7 "ARM: create a common IOMEM definition" moved macro
>> IOMEM(), and requires users to include <asm/assembler.h>. Fix Tegra's
>> sleep.S to do so.
>>
>> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Arnd,

Can you pick up this fix directly into arm-soc, or do you want me to
generate a pull request for this kind of thing too?

ARM: tegra: Include assembler.h in sleep.S to fix build break
http://patchwork.ozlabs.org/patch/147587/

The same goes for:

ARM: tegra: Fix device tree AUXDATA for USB/EHCI
http://patchwork.ozlabs.org/patch/147616/

Thanks.
