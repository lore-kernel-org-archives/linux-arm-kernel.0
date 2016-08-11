From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 11 Aug 2016 11:58:48 +0100
Subject: [PATCH v10 0/8] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <CADyBb7tZDT2LMGnsWW_orR37dsfseijLEjzn59rLW9tbbxKVPQ@mail.gmail.com>
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
 <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com>
 <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
 <CADyBb7tZDT2LMGnsWW_orR37dsfseijLEjzn59rLW9tbbxKVPQ@mail.gmail.com>
Message-ID: <20160811105848.GA25680@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 06:22:03PM +0800, Fu Wei wrote:
> Hi Hanjun, Tomasz,
> 
> On 11 August 2016 at 18:15, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > Hi,
> >
> > On 2016/8/11 17:37, Tomasz Nowicki wrote:
> >>
> >> Hi Fu,
> >>
> >> Do you mind if I send IORT series where new drivers/acpi/arm64 directory
> >> would be introduced in first place ? This means your GTDT set would
> >> depend on IORT.
> >
> >
> > I think it's reasonable as the IORT for ITS is the key device enablement
> > for PCI MSI. I talked to Fuwei offline and he is fine with it.
> 
> That's no problem at all, will do.
> 
> Can I do this:
> (1)apply Tomasz's v8 patchset on the master branch of upstream kernel
> (2)rebase my v10 on the top of Tomasz's v8
> (3)git format-patch as v11, repost it
> 
> Is that OK for everyone? :-)

I do not think you need a v11 just to remove the drivers/acpi/arm64
directory creation, you need to get Daniel/Thomas review/ack on
the respective patches though, I do not see the point of churning
out another series just because drivers/acpi/arm64 is now created
in the IORT patch series. If v10 is ok you will rebase it on top of
Tomasz's series and mention the dependency in the respective pull
request.

If there is need for a v11 following Daniel/Thomas review yes,
you can proceed as above.

Lorenzo
