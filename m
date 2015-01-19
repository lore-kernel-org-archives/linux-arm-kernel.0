From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Jan 2015 16:05:26 +0100
Subject: [PATCH v4 0/4] ata: libahci: Allow using a regulator for each port
In-Reply-To: <20150119145413.GJ8140@htj.dyndns.org>
References: <1421330978-9694-1-git-send-email-gregory.clement@free-electrons.com>
 <54B8C49A.9070302@redhat.com>
 <20150119145413.GJ8140@htj.dyndns.org>
Message-ID: <20150119150526.GB32663@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 09:54:13AM -0500, Tejun Heo wrote:
> On Fri, Jan 16, 2015 at 08:58:18AM +0100, Hans de Goede wrote:
> > Hi,
> > 
> > On 15-01-15 15:09, Gregory CLEMENT wrote:
> > >The current implementation of the libahci allows using one PHY per
> > >port but we still have one single regulator for the whole
> > >controller. This series adds the support of multiple regulators.
> > >
> > >This is the forth version of the series.
> > >
> > >The improvement of this version is the use of
> > >ahci_platform_put_resources to put the reference to the regulators.
> > >
> > >Thanks,
> > >
> > >Gr?gory
> > 
> > Thanks, patches 1 - 3 look good and are:
> > 
> > Acked-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Tejun, can you please queue up 1 - 3 ?
> 
> Applied 1-3 to libata/for-3.20.

Thanks

I will add 4/4 to mvebu/dt.

  Andrew
