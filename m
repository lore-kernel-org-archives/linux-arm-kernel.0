From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 14 Jan 2015 15:24:53 +0530
Subject: [PATCH] arch: arm: common: edma.c:  Remove some unused functions
In-Reply-To: <54A10868.70001@ti.com>
References: <1417906406-5527-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <54A10868.70001@ti.com>
Message-ID: <54B63CED.1020603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 December 2014 01:23 PM, Peter Ujfalusi wrote:
> On 12/07/2014 12:53 AM, Rickard Strandqvist wrote:
>> Removes some functions that are not used anywhere:
>> edma_shadow0_read() edma_or_array()
>>
>> This was partially found by using a static code analysis program called cppcheck.
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Queuing for v3.20 through ARM-SoC.

The correct prefix for ARM patches is "ARM: ". I will fix while
applying. Please take care next time on.

Thanks,
Sekhar
