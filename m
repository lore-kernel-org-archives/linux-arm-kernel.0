From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Fri, 05 Sep 2014 10:23:09 +0300
Subject: [PATCH v2] ARM: msm: Update the references to DEBUG_MSM_UARTx
In-Reply-To: <1409870314.5546.128.camel@x220>
References: <1401116287.6068.15.camel@x220>	
 <1401122260-12002-1-git-send-email-gdjakov@mm-sol.com>	
 <1403165772.23136.17.camel@x220> <1409870314.5546.128.camel@x220>
Message-ID: <540964DD.7070203@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2014 01:38 AM, Paul Bolle wrote:
> On Thu, 2014-06-19 at 10:16 +0200, Paul Bolle wrote:
>> On Mon, 2014-05-26 at 19:37 +0300, Georgi Djakov wrote:
>>> The Kconfig options DEBUG_MSM_UART1, DEBUG_MSM_UART2, DEBUG_MSM_UART3,
>>> MSM_DEBUG_UART1, MSM_DEBUG_UART2 and MSM_DEBUG_UART3 are removed, but 
>>> they are still referenced in the following files:
>>> 	arch/arm/mach-msm/io.c,
>>> 	arch/arm/mach-msm/board-trout.c
>>> 	arch/arm/mach-msm/board-trout-gpio.c
>>>
>>> Fix this by updating the reference to the new Kconfig option.
>>>
>>> Reported-by: Paul Bolle <pebolle@tiscali.nl>
>>> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
>>> ---
>>
>> This patch is included neither in v3.16-rc1 nor in next-20140619.
> 
> Still true for v3.17-rc3 and next-20140904.
> 

Hi Paul,
It was pulled yesterday into the msm/cleanup branch of the arm-soc tree.

Thanks,
Georgi
