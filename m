From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 12 Feb 2015 18:46:33 -0700
Subject: [PATCH v3 1/2] coresight: Adding coresight support for arm64
 architecture
In-Reply-To: <20150212094911.GA1028@e104818-lin.cambridge.arm.com>
References: <1423629085-1044-1-git-send-email-mathieu.poirier@linaro.org>
 <20150211113651.GC9058@e104818-lin.cambridge.arm.com>
 <CANLsYky9sGK=vpEM5kMD8HZJ_a+hyU58sV=u=KHe9+oKGhGCqA@mail.gmail.com>
 <20150212094911.GA1028@e104818-lin.cambridge.arm.com>
Message-ID: <CANLsYkzSQX3V7GD6wbmA+jFXBk8YSB465E0XbpFaUYYbbbAbnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2015 at 02:49, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Feb 11, 2015 at 07:54:04PM -0700, Mathieu Poirier wrote:
>> On 11 February 2015 at 04:36, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Tue, Feb 10, 2015 at 09:31:24PM -0700, mathieu.poirier at linaro.org wrote:
>> >> From: Mathieu Poirier <mathieu.poirier@linaro.org>
>> >>
>> >> Most CoreSight blocks are 64-bit ready.  As such move configuration
>> >> entries from "arch/arm/Kconfig.config" to the driver's subdirectory
>> >> and source the newly created Kconfig from architecture specific
>> >> Kconfig.debug files.
>> >>
>> >> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> >> ---
>> >> Change for v3:
>> >>   - Separating Kconfig work from compilation warnings fixes.
>> >
>> > Nitpick: merge the compilation warnings fix first so that we don't get
>> > them once the Kconfig patch is merged for arm64.
>> >
>> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>>
>> I intended to merge both patches via my tree and as such ensuring the
>> Kconfig changes and compilation warnings fix go in at the same time.
>> Is this fine with you?
>
> It was more about bisectability. If reordering is problematic (already
> published branch etc.), leave them as they are.

Other than on this mailing list the code hasn't been published.  I
will re-order the patches.

Thanks for the reviews,
Mathieu

>
> --
> Catalin
