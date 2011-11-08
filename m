From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 8 Nov 2011 17:25:52 +0800
Subject: [PATCH v5 3/7] arm: perf: support device with other non-irq
 resources
In-Reply-To: <alpine.DEB.2.00.1110250459160.12667@utopia.booyaka.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-4-git-send-email-ming.lei@canonical.com>
 <20111024150814.GA4771@mudshark.cambridge.arm.com>
 <CACVXFVOzQ0QEnaAb=mLFdr7AU3H3TsT=wXcNgtqeUGVLXahd4Q@mail.gmail.com>
 <20111025083420.GA6184@mudshark.cambridge.arm.com>
 <alpine.DEB.2.00.1110250242130.27118@utopia.booyaka.com>
 <CACVXFVOVeuWpVGSUP-sDDbiWb=W8XVB+PDYns4ttK9+ty0GMmA@mail.gmail.com>
 <alpine.DEB.2.00.1110250459160.12667@utopia.booyaka.com>
Message-ID: <CACVXFVPD90q0euQXXG+3ujyvzxCjAovFSSPKvqf6esU7vkD7Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2011 at 7:00 PM, Paul Walmsley <paul@pwsan.com> wrote:
> + Beno?t
>
> Hi
>
> On Tue, 25 Oct 2011, Ming Lei wrote:
>
>> On Tue, Oct 25, 2011 at 4:44 PM, Paul Walmsley <paul@pwsan.com> wrote:
>> > On Tue, 25 Oct 2011, Will Deacon wrote:
>> >
>> >> Hurrah! If you can get the OMAP / hwmod bits acked by the OMAP guys then I'm
>> >> happy to take the perf and PMU changes into my tree.
>> >
>> > I'd suggest that you take the perf/PMU stuff yourself if you are happy
>> > with it, and then we'll deal with the OMAP bits ourselves, since it looks
>> > like they aren't dependent on each other, and the OMAP parts will need
>> > changes.
>>
>> One omap4 patch(struct arm_pmu_platdata related) depends on 2/7, which
>> need to be rebased. But I still suggest that arm perf/PMU stuff may be
>> merged first.
>>
>> Paul, expect your comments on OMAP4 parts.
>
> Beno?t is the right person to review OMAP4 hwmod data.

Beno?t, gentle ping, :-)

thanks,
--
Ming Lei
