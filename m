From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 31 Oct 2018 15:54:30 -0700
Subject: [PATCH v2] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS
 disabled
In-Reply-To: <20181025192621.GB16785@lunn.ch>
References: <20181025190110.7564-1-f.fainelli@gmail.com>
 <20181025192621.GB16785@lunn.ch>
Message-ID: <caf4adfa-9938-0f53-75c1-48bce6095093@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/18 12:26 PM, Andrew Lunn wrote:
> On Thu, Oct 25, 2018 at 12:01:08PM -0700, Florian Fainelli wrote:
>> Some software such as perf makes unconditional use of the special
>> [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
>> enabled in the kernel.
>>
>> Facilitate the debugging of such situations by printing a debug message
>> to the kernel log showing the task name and the faulting address.
> 
> Hi Florian
> 
> Nice. I wish we had this a couple of months ago.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks Andrew, submitted as 8807/1.
-- 
Florian
