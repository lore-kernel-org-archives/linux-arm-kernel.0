From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 Feb 2012 09:04:07 +0000
Subject: [PATCH 1/4] Remove Telechips ARM subarch from MAINTAINERS
In-Reply-To: <20120202195653.GA5558@local>
References: <20111222211948.GA1201@local> <201202021346.08740.arnd@arndb.de>
 <20120202195653.GA5558@local>
Message-ID: <201202030904.07822.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 February 2012, Hans J. Koch wrote:
> 
> On Thu, Feb 02, 2012 at 01:46:08PM +0000, Arnd Bergmann wrote:
> > 
> > Telechips themselves seem to have given up on the ARM9 based products
> 
> That is not true. The TCC8000 is in production and available, also
> derivatives like TCC8001.
> 
> The main problem is that Telechips is not interested in markets where
> SoCs are sold separately. Instead, they sell complete solutions.
> If you want a new DAB car radio, they'll sell you the PCB layout,
> operating system, drivers, and complete software according to your
> specification. They'll even organise manufacturing of the device,
> and you'll get the completely working PCB in the end. You never have
> to write software yourself, let alone kernel code.

Ok, thanks for the info. Well, it also seems that Telechips is not
particularly interested in contributing to upstream either, and
according to what I've found in discussions were quite reluctant
event to provide source code where they were required to.

They did provide the 2.6.29 and 2.6.35 kernel sources for their
newer SoCs in the end, but I could not find anything for their ARMv5
parts, or any newer sources if they have any. 

	Arnd
