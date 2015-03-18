From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 18 Mar 2015 16:09:43 +0530
Subject: [RFC PATCH v4 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <20150318100004.GC18951@arm.com>
References: <1421924755-26029-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1421924755-26029-4-git-send-email-gkulkarni@caviumnetworks.com>
 <2882934.brFyhkGPyE@wuerfel> <1885509.Z0Gm3e3FlX@wuerfel>
 <CAFpQJXUvux+b9hYx_ZY-1hor0HRFFgh=e4vCYyJiDHrDC9Y=tQ@mail.gmail.com>
 <CAFpQJXXkXatxRcfpA1DjuuiUf3vup3DV+dACyGxT=TDkrO8rNQ@mail.gmail.com>
 <CAFpQJXVc5c=YRLw3uS5RiSR13veo_SUiM-aV6hf+diQuWxdfYQ@mail.gmail.com>
 <CAFpQJXWL-NM+WndfB5pLj6TmdVngACR9YCr_ahaUTqAO3DaX1g@mail.gmail.com>
 <20150318100004.GC18951@arm.com>
Message-ID: <CAFpQJXWzhn=sFKOdbPGXGfQNr5outJodTH72RoC1VVYqt8jmdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Will.

On Wed, Mar 18, 2015 at 3:30 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Mar 18, 2015 at 04:02:53AM +0000, Ganapatrao Kulkarni wrote:
>> Hi Catalin, Will, Mark, Arnd
>
> [...]
>
>> Please suggest how we go about these patches.
>> please share your review comments, if any changes needs to be done.
>
> I can take the Kconfig patch if you send a version that applies cleanly.
> As for the rest, you need an ack from a DT maintainer on the bindings
> before anything else can get merged.
i will send you Kconfig patch (i.e increase NR_CPUS range to 2-4096)
separately after rebasing to
linux-next, is that ok?
>
> Will
thanks
Ganapat
