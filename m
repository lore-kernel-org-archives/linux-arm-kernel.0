From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 15 Apr 2014 20:20:13 +0200
Subject: [PATCH v2 4/5] mmc: dove: prepare new Dove DT Kconfig variable
In-Reply-To: <533442B9.80900@gmail.com>
References: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393662801-17950-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140304040357.GH1872@titan.lakedaemon.net> <533442B9.80900@gmail.com>
Message-ID: <534D785D.50704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2014 04:24 PM, Sebastian Hesselbarth wrote:
> On 03/04/2014 05:03 AM, Jason Cooper wrote:
>> On Sat, Mar 01, 2014 at 09:33:20AM +0100, Sebastian Hesselbarth wrote:
>>> DT-enabled Dove will move over from ARCH_DOVE in mach-dove to
>>> MACH_DOVE in
>>> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
>>> DT-only MACH_DOVE Kconfig.
>>>
>>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> ---
>>> Chris,
>>>
>>> Mark Brown requested to take the corresponding ASoC patch through
>>> his tree. Therefore, I have split the former patch into individual
>>> subsystem
>>> patches.
>>>
>>> Cc: Chris Ball <chris@printf.net>
>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>> Cc: Andrew Lunn <andrew@lunn.ch>
>>> Cc: Gregory Clement <gregory.clement@free-electrons.com>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-kernel at vger.kernel.org
>>> ---
>>>   drivers/mmc/host/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> Ping. Chris, can you please take it in for v3.15-rc1?

Ping again.

Chris, anything wrong with this one? It still applies to
v3.15-rc1 and is required to get sdhci working again on
MULTI_V7 Dove.

Sebastian
