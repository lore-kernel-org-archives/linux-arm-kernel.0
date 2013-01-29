From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 13:21:30 +0000
Subject: [PATCH 5/5] ARM: SPEAr13xx: Pass generic DW DMAC platform data
 from DT
In-Reply-To: <CAKohpokrvYDaMgB-5HV+bJh01YNU4H5UrSUnzxa_NpvE1qQqiA@mail.gmail.com>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-6-git-send-email-arnd@arndb.de>
 <CAKohpokrvYDaMgB-5HV+bJh01YNU4H5UrSUnzxa_NpvE1qQqiA@mail.gmail.com>
Message-ID: <201301291321.30726.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Viresh Kumar wrote:
> You forgot spear-devel for this series.

Ok, thanks for adding it.

> > +                       dma-channels = <8>;
> > +                       #dma-cells = <3>;

Yep, my mistake again. It was correct in v1 of the patch and then
I changed it so it had to be 4.

	Arnd
