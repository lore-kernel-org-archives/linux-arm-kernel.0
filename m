From: cjb@laptop.org (Chris Ball)
Date: Tue, 23 Apr 2013 15:07:35 -0400
Subject: [PATCH 12/21] mmc: sdhci-tegra: fix MODULE_DEVICE_TABLE
In-Reply-To: <201304232055.32715.arnd@arndb.de> (Arnd Bergmann's message of
 "Tue, 23 Apr 2013 20:55:32 +0200")
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-13-git-send-email-arnd@arndb.de>
 <87bo95tctk.fsf@octavius.laptop.org>
 <201304232055.32715.arnd@arndb.de>
Message-ID: <8738uht6a0.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 23 2013, Arnd Bergmann wrote:
>> I was going to take this, but it doesn't apply to mmc-next or
>> linux-next, because the #endif in your first line of context isn't
>> present in those trees -- which tree is this based on?
>
> I based it on 3.9-rc8.

Thanks, I should have thought of that; applied to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
