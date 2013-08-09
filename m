From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 9 Aug 2013 17:08:44 +0530
Subject: [PATCH] ARM: EXYNOS: Set 64-bit DMA mask for EXYNOS5250
In-Reply-To: <20130809111608.GR23006@n2100.arm.linux.org.uk>
References: <1376042714-26513-1-git-send-email-tushar.behera@linaro.org>
 <20130809102752.GP23006@n2100.arm.linux.org.uk>
 <CAHbNUh1z8ULaxpJuHe=B5+ey+19LznD_tzSopJ6y3h09rw=-8g@mail.gmail.com>
 <20130809111608.GR23006@n2100.arm.linux.org.uk>
Message-ID: <CAHbNUh0Tn2P7ngMPaJOTpvwfHyYLFV03HaK_0gix_3vbs_uE8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 August 2013 16:46, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Fri, Aug 09, 2013 at 04:41:57PM +0530, Tushar Behera wrote:
>> On 9 August 2013 15:57, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> > On Fri, Aug 09, 2013 at 03:35:14PM +0530, Tushar Behera wrote:
>> >> When LPAE is enabled, we need to set 64bit DMA mask bits.
>> >
>> > *Please* check the list archives.  I sent during the last 7 days a patch
>> > series which should address this problem.  Unfortunately, it seems almost
>> > no one has looked at it.
>>
>> Thanks for the patchset. Tested on Arndale.
>
> Thanks - can I assume that's a proper Tested-by: ?  Also, please confirm
> the patch numbers which you tested.  Thanks.

Replied to [PATCH 46/51] with a Tested-by.

-- 
Tushar Behera
