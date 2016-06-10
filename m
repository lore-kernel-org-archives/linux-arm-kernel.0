From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 10 Jun 2016 13:44:54 +0100
Subject: [RFC PATCH 07/15] ARM: exynos: fixup debug macros for big-endian
In-Reply-To: <575AA193.7040907@samsung.com>
References: <20160608183110.13851-1-matthew@mattleach.net>
 <20160608183110.13851-8-matthew@mattleach.net>
 <ab51fcde-dfee-a70c-53c4-09485bfa7669@codethink.co.uk>
 <575AA193.7040907@samsung.com>
Message-ID: <f789b996-2679-b28a-0d12-fb747bc750cd@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/16 12:16, Krzysztof Kozlowski wrote:
> On 06/10/2016 01:12 PM, Ben Dooks wrote:
>> On 08/06/16 19:31, Matthew Leach wrote:
>>> From: Ben Dooks <ben.dooks@codethink.co.uk>
>>>
>>> The exynos low-level debug macros need to be fixed if the system is being
>>> built big endian. Add the necessary endian swaps for accessing the registers
>>> to get output working again
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> ---
>>>  arch/arm/include/debug/samsung.S | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>
>> Should this go via the maintainer or to RMK?
>>
>> If to RMK, then shall I get it submitted (and does anyone else
>> want to ack?)
> 
> If there are no objections, I can take it through samsung-soc with other
> arch/arm/mach-exynos* patches.
> 
> What I am missing here, is Matthew's Signed-off-by.
> 
> Matthew, you touched and sent the patch so could you add the Sob?

Either that or I could just send it from my tree directly.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
