From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Thu, 26 Sep 2013 16:09:12 -0400 (EDT)
Subject: [PATCH] misc: (at24) move header to linux/platform_data/
In-Reply-To: <169123028.921974.1377290733515.JavaMail.root@mail>
Message-ID: <1414767040.1054326.1380226152008.JavaMail.root@mail>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

> Wolfram wrote:
> 
> > > IMHO it makes sense. Why wouldn't we want all platform_data in
> > > include/linux/platform_data/?
> > 
> > For the same reason we don't want all driver source files in one
> > directory? It's a mess.
> 
> Well, that's different. Not all drivers expose platform data, but
> many subsystems have drivers with platform data. A common include
> directory for the *_platform_data structure definitions makes sense.

Also IMO having such header file in include/linux/i2c/ for a driver
declared in drivers/misc/eeprom/ is not very consistent.
So this is the purpose of this include directory. What do you think?

Best,
Vivien
