From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 5 Mar 2017 22:21:33 -0800
Subject: [GIT PULL 1/2] Broadcom dts changes for 4.11 (part 2)
In-Reply-To: <20170306042913.phr6ooew4mkcbss6@tarshish>
References: <20170202020607.31682-1-f.fainelli@gmail.com>
 <20170306042913.phr6ooew4mkcbss6@tarshish>
Message-ID: <aa4a7b78-3cd9-66d0-953c-961cb10c9207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/05/2017 08:29 PM, Baruch Siach wrote:
> Hi Florian, ARM SoC maintainers,
> 
> On Wed, Feb 01, 2017 at 06:06:07PM -0800, Florian Fainelli wrote:
>> The following changes since commit c5a8e3add28ca4063410353acfbe6e650174e432:
>>
>>   Merge tag 'bcm2835-dt-next-2017-01-17' into devicetree/next (2017-01-18 17:20:32 -0800)
>>
>> are available in the git repository at:
>>
>>   http://github.com/Broadcom/stblinux tags/arm-soc/for-4.11/devicetree-part2
>>
>> for you to fetch changes up to c206e53d4c672ec83a4fc4d70eeac22d4b4ca80d:
>>
>>   Merge tag 'bcm2835-dt-next-2017-01-31' into devicetree/next (2017-02-01 17:37:59 -0800)
>>
>> ----------------------------------------------------------------
>> This pull request contains the second round of Device Tree updates for Broadcom
>> ARM-based SoCs for 4.11, please pull the following:
>>
>> - Rafal adds support for two new Linksys routers: Linksys EA9200 (BCM4709) and
>>   Linksys EA6300 V1 (BCM4708)
>>
>> - Dhanajay adds supports for the USB Device Tree nodes to the Northstar Plus
>>   SoC
>>
>> - Baruch makes several fixes to the uart0 pinctrl node names, fixes the i2c0 pins
>>   and the uart0/uart1 pins as well. Finally, he adds proper indexes to the ethernet
>>   aliases
>>
>> - Eric merges a topic branch from the clk tree to incorporate several DSI0/1 pixel
>>   clock requirements and he finally proceeds with adding proper DSI modules nodes
>>   and clocks to the BCM2835 Device Tree
>>
>> Please note that because of the "clk" topic branch merged by Eric, we end-up with
>> pulling in v4.10-rc2 which is responsible for the funny diff here.
> 
> What happened to this pull request? v4.11-rc1 is out now.

It was submitted too late, and therefore got postponed, so everything
that's in there should show up for 4.12 now once Eric re-submits the
BCM283x pull request in a few days.
-- 
Florian
