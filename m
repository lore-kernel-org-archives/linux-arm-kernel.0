From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 04 Jan 2012 16:37:25 +0100
Subject: [PATCH 6/6] mmc: sdhci-s3c: Add device tree support
In-Reply-To: <CAJuYYwSfC5t6xs-TDT2wBOj1RbQYSpH0wjo9uBcYf7bGyi0t9g@mail.gmail.com>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
 <1320266163-15292-7-git-send-email-thomas.abraham@linaro.org>
 <20111107211726.GC28491@ponder.secretlab.ca>
 <CAJuYYwSfC5t6xs-TDT2wBOj1RbQYSpH0wjo9uBcYf7bGyi0t9g@mail.gmail.com>
Message-ID: <4F047235.2090503@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene, Thomas

On 11/08/2011 04:23 PM, Thomas Abraham wrote:
> Hi Grant,
> 
> On 8 November 2011 02:47, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Thu, Nov 03, 2011 at 02:06:03AM +0530, Thomas Abraham wrote:
>>> Add device tree based discovery support for Samsung's sdhci controller
>>>
>>> Cc: Ben Dooks <ben-linux@fluff.org>
>>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>>> ---
>>> +Example:
>>> +     sdhci at 12530000 {
>>> +             compatible = "samsung,exynos4210-sdhci";
>>> +             reg = <0x12530000 0x100>;
>>> +             interrupts = <139>;
>>> +             samsung,sdhci-bus-width = <4>;
>>> +             linux,mmc_cap_4_bit_data;
>>
>> Following on from my reply on patch 5, this is an example of exactly
>> what I'm talking about.  This node both sets bus-width to '4', and
>> sets the 4_bit_data flag.  Don't you think that the driver would be
>> smart enough to set the 4_bit_data flag when the bus width was set to
>> 4?
> 
> Yes, that is true. I will modify the driver based on your comments and
> resubmit this patch.

Are we going to have those patches in 3.3-rc1 or only in 3.4 ?

--
Regards,
Sylwester
