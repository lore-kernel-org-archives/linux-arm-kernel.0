From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 11:42:46 +0100
Subject: [RFC 1/5] ARM: dev_archdata: add private iommu extension
In-Reply-To: <CAK=Wgbau+XZ-c21FCT8DT0NYfm2uD6WZv3=cU2R23pV7LUkxEA@mail.gmail.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
	<1316948337-7924-2-git-send-email-ohad@wizery.com>
	<CAK=Wgba6xxD2DBJhM--AcTPBoNRiOZ_6f8+j3bfaCqZMO8A4+w@mail.gmail.com>
	<CAK=Wgbau+XZ-c21FCT8DT0NYfm2uD6WZv3=cU2R23pV7LUkxEA@mail.gmail.com>
Message-ID: <20111013104246.GA22076@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 11:15:39AM +0200, Ohad Ben-Cohen wrote:
> On Wed, Oct 5, 2011 at 11:26 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> > Hi Russell,
> >
> > On Sun, Sep 25, 2011 at 1:58 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> >> Add a private iommu pointer to the ARM-specific arch data in the
> >> device struct, which will be used to attach iommu-specific data
> >> to devices which require iommu support.
> >
> > Can you please take a look and ack/nack ?
> 
> gentle reminder

Ok, I'll take it if you put it in the patch system.

Thanks.
