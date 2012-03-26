From: khilman@ti.com (Kevin Hilman)
Date: Mon, 26 Mar 2012 16:09:07 -0700
Subject: [PATCH 9/9] ARM: omap: select CPU_FREQ_TABLE where needed
In-Reply-To: <20120323182746.GF9859@atomide.com> (Tony Lindgren's message of
 "Fri, 23 Mar 2012 11:27:46 -0700")
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
 <1332522836-29517-10-git-send-email-mathieu.poirier@linaro.org>
 <20120323182746.GF9859@atomide.com>
Message-ID: <87limnq7sb.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * mathieu.poirier at linaro.org <mathieu.poirier@linaro.org> [120323 10:17]:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The omap platform requires CPU_FREQ_TABLE support to be enabled for its
>> CPU_FREQ implementations, so automatically select that when CPU_FREQ
>> is enabled.
>
> I think this is also solved now, Kevin might be able to confirm this.

Yes, this is solved in mainline by selecting it from
drivers/cpufreq/Kconfig.arm

Kevin
