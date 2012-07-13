From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jul 2012 13:23:26 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay
 implementation to be selected
In-Reply-To: <CAMQu2gykoJpw+sAvGYK2++i=GXHuSUF8YKD3o8nv-vpZzTL=Gg@mail.gmail.com>
References: <20120712084432.GA2816@mudshark.cambridge.arm.com>
 <4FFE9A69.3060301@renesas.com> <4FFEFDE3.5000403@codeaurora.org>
 <4FFF8509.2050302@renesas.com>
 <20120713085746.GA18079@mudshark.cambridge.arm.com>
 <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
 <20120713111337.GH18079@mudshark.cambridge.arm.com>
 <CAMQu2gyUWYOmRNAiHJ-3-feThaEjC5cUO3krsNPX4PTFHqFF=Q@mail.gmail.com>
 <20120713120857.GJ18079@mudshark.cambridge.arm.com>
 <CAMQu2gykoJpw+sAvGYK2++i=GXHuSUF8YKD3o8nv-vpZzTL=Gg@mail.gmail.com>
Message-ID: <20120713122325.GK18079@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 01:14:59PM +0100, Shilimkar, Santosh wrote:
> On Fri, Jul 13, 2012 at 5:38 PM, Will Deacon <will.deacon@arm.com> wrote:
> > Well, your bogomips number will probably be *much* lower than before, so
> > don't be surprised by that.
> >
> Indeed !!
> This is what I observed. Can we not keep that behavior old way. BogoMIPS and
> CPU clock is often very easy to co-related and helpful for CPUFREQ stats.

I defer to David Miller, who had a similar reaction when he did this for
sparc:

http://www.spinics.net/lists/sparclinux/msg08550.html

Will
