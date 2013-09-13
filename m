From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 13 Sep 2013 08:23:44 -0700
Subject: [PATCH] drivers: cpuidle: rename ARM big.LITTLE driver config and
 makefile entries
In-Reply-To: <20130913140125.GA2062@e102568-lin.cambridge.arm.com> (Lorenzo
 Pieralisi's message of "Fri, 13 Sep 2013 15:01:25 +0100")
References: <1379071966-26757-1-git-send-email-lorenzo.pieralisi@arm.com>
 <5232FCD4.2070802@free-electrons.com>
 <20130913140125.GA2062@e102568-lin.cambridge.arm.com>
Message-ID: <87ppscg2yn.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> On Fri, Sep 13, 2013 at 12:53:56PM +0100, Gregory CLEMENT wrote:
>> Hi Lorenzo,
>> 
>> On 13/09/2013 13:32, Lorenzo Pieralisi wrote:
>> > Following the reorganization of CPU idle drivers configurations into an ARM
>> > specific Kconfig, the existing idle drivers Kconfig entries were renamed and
>> > moved to the Kconfig.arm file. Makefile entries were updated accordingly.
>> > 
>> > This patch renames the entries in Kconfig.arm and makefile to make the newly
>> > added big.LITTLE CPUidle driver compliant with the new naming convention.
>> 
>> Do you also consider to reorder the entries in alphabetic order?
>> It should help to reduce the merge conflict.
>
> Sure, here it is, thanks for pointing that out.

FYI, updated patches deep inside threads are very likely to be missed.
I saw this because I was looking for it, but would've easily been
missed.

Could you resend a v2 with my ack so Daniel can pick up and get it
merged for v3.12-rc?  Thanks

Acked-by: Kevin Hilman <khilman@linaro.org>

Kevin
