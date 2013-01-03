From: robherring2@gmail.com (Rob Herring)
Date: Thu, 03 Jan 2013 16:19:26 -0600
Subject: [PATCH v4 15/19] ARM: samsung: remove unused tick.h
In-Reply-To: <201301032151.32337.arnd@arndb.de>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-16-git-send-email-robherring2@gmail.com>
 <201301032151.32337.arnd@arndb.de>
Message-ID: <50E603EE.9030504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2013 03:51 PM, Arnd Bergmann wrote:
> On Thursday 03 January 2013, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Remove tick.h on s5p64x0 and s5pv210 as they are unused.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: linux-samsung-soc at vger.kernel.org
>> ---
>>  arch/arm/mach-s5pv210/include/mach/tick.h |   26 --------------------------
>>  arch/arm/plat-samsung/s5p-irq-eint.c      |    1 +
>>  2 files changed, 1 insertion(+), 26 deletions(-)
>>  delete mode 100644 arch/arm/mach-s5pv210/include/mach/tick.h
> 
> The second half of the patch does not relate to the description,
> and the first half looks correct but out of place here.

The first half is relevant in that it eliminates an occurrence of VIC
defines, but could be applied separately. I'm not sure what happened
with mach-s5p64x0/include/mach/tick.h as that should be removed too.

The second half should be in patch 19.

Rob

> Did you accidentally fold another patch into the one you wanted,
> or am I just misreading the intention of the patch?
> 
> 	Arnd
> 
