From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Tue, 24 Jul 2012 18:06:06 +0900
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <20120720101751.GB26658@mudshark.cambridge.arm.com>
References: <4FFEFDE3.5000403@codeaurora.org> <4FFF8509.2050302@renesas.com>
 <20120713085746.GA18079@mudshark.cambridge.arm.com>
 <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
 <20120713111337.GH18079@mudshark.cambridge.arm.com>
 <5004D78E.4050606@renesas.com>
 <CAMQu2gx9EU4GZ634RKiwD+sg0MoO-FAqc-pPU+HkryX8rXVBjA@mail.gmail.com>
 <5005176C.6050904@renesas.com>
 <20120718175233.GB16928@mudshark.cambridge.arm.com> <50082598.5090706@arm.com>
 <20120720101751.GB26658@mudshark.cambridge.arm.com>
Message-ID: <500E657E.8070301@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Jonathan,

On 7/20/2012 7:17 PM, Will Deacon wrote:
> On Thu, Jul 19, 2012 at 04:19:52PM +0100, Jonathan Austin wrote:
>> We should probably also ignore and additional registration calls, not just
>> those made after the delay loop has been calibrated...
>>
>> Something like the patch below should do the trick.
> 
> [...]
> 
> Cheers, pushed into my delay branch.

Thanks for the registration machanism.  It looks nice, and works for
me on a Cortex-A9 SMP platform with a non-arch_timer counter.

I've picked up a revised version of the patch from will/delay and
merged it into our local development branch.  We'll give it a try
in different conditions, UP and SMP, with/without DVFS and so on,
and let you know if I find anything.

-- 
Shinya Kuribayashi
Renesas Electronics
