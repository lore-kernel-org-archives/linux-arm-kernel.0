From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 12:45:07 +0200
Subject: [PATCH v2 04/11] arm64: dts: sc9836/sc9860: Update coresight
 bindings for hardware ports
In-Reply-To: <CAAfSe-swWPgCWN6cZbQxLL6fwaJ1qLXnC_X7A0zeYuHDaZ_A1Q@mail.gmail.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
 <20180912135352.19722-5-suzuki.poulose@arm.com>
 <ccc61e1b-768c-2a6d-3ff5-95b72bc58a6f@arm.com>
 <CAAfSe-swWPgCWN6cZbQxLL6fwaJ1qLXnC_X7A0zeYuHDaZ_A1Q@mail.gmail.com>
Message-ID: <CAK8P3a2WWFp5W5-7o-X3joOpSGgnK=s_ZyGev7gsVV0SjN0p0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 11:19 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> Hi Suzuki,
>
> On 27 September 2018 at 16:51, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> > +To: Chunyan Zhang
> >
> > Chunyan Zhang,
> >
> > On 09/12/2018 02:53 PM, Suzuki K Poulose wrote:
> >>
> >> Switch to the new coresight bindings for hw ports
> >>
> >
> > How can we push this patch ? Do you generally send the spreadtrum
> > specific changes to ARM soc folks ? Or would you like me to post
> > this directly to ARM soc folks ?
>
> Yeah, at present sprd dts files generally got merged through arm-soc
> (I've added arm at kernel.org).

Yes, that's fine. Generally, we prefer if you collect patches for your
platform first, and then send them as a pull request or short set
of patches. for inclusion, rather than picking them up from the list.

If this is the only DT patch for spreadtrum in 4.20, I can also just
pick it up with your Ack.

       Arnd
