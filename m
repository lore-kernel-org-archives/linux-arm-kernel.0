From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Sep 2012 11:29:54 -0600
Subject: [PATCH 09/16] ARM: tegra: move platform_data definitions
In-Reply-To: <201209121621.16019.arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-9-git-send-email-arnd@arndb.de>
 <504F5A51.9000506@wwwdotorg.org> <201209121621.16019.arnd@arndb.de>
Message-ID: <5050C692.1070503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2012 10:21 AM, Arnd Bergmann wrote:
> On Tuesday 11 September 2012, Stephen Warren wrote:
> 
>>>  .../mach/sdhci.h => include/linux/platform_data/mmc-sdhci-tegra.h  |    0
>>
>> I have a not-yet-applied (but ack'd by Chris Ball) patch to move this to
>> include/linux/mmc/tegra_sdhci.h. I believe all the dependencies are
>> staged in the Tegra tree now, so I can apply it if you want. I'm fine
>> with you apply this patch though; just let me know. If you want to take
>> your patch, then this part:
>>
>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> 
> I've redone my patch now, the version below is what I have now.

OK, that looks fine.
