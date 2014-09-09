From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 09 Sep 2014 09:26:42 +0100
Subject: [PATCH v3 0/5] arm: Implement arch_trigger_all_cpu_backtrace
In-Reply-To: <20140908162449.GD12361@n2100.arm.linux.org.uk>
References: <1409931198-22600-1-git-send-email-daniel.thompson@linaro.org>
 <1410190115-32604-1-git-send-email-daniel.thompson@linaro.org>
 <20140908162449.GD12361@n2100.arm.linux.org.uk>
Message-ID: <540EB9C2.3070401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/14 17:24, Russell King - ARM Linux wrote:
> On Mon, Sep 08, 2014 at 04:28:30PM +0100, Daniel Thompson wrote:
>> * Restructured to sit nicely on a similar FYI patchset from Russell
>>   King. It now effectively replaces the work in progress final patch
>>   with something much more complete.
> 
> I'd suggest that patch 2 should be in a different place - get the FIQ
> infrastructure in place first before adding any users of it would be
> a much more sensible patch ordering.

Ok. I will push this to the back.
