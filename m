From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Aug 2010 17:02:37 +0200
Subject: [PATCH/RFC] Samsung device-table approach
In-Reply-To: <1281530427.1918.124.camel@chotu>
References: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
	<1281530427.1918.124.camel@chotu>
Message-ID: <003101cb3966$3f999bb0$beccd310$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, August 11, 2010 2:40 PM Ameya Palande wrote:

> On Wed, 2010-08-11 at 14:03 +0200, ext Marek Szyprowski wrote:
> > Hello,
> >
> > I would like to start the discussion on the redesign of the way the
> > Samsung platform devices are defined. The current solution has some
> > important disadvantages that blocks the further kernel development.
> 
> Forgive me about my ignorance about device tables, but I was wondering
> if there is any similarity between device tables and Simple Firmware
> Interface tables which are already in mainline?

Well, this will be a funny discussion of two ignoramuses, as I know
almost nothing about Simple Firmware Interface. 

However I've read briefly about it and I see that SFI device tables are
something that is being defined at a boot loader level.

Current mainline kernel for Samsung SoC already contains definitions
for many devices (well, they should be called 'integrated peripherals'
in fact). The boot loader provides only a very basic information to
kernel (just the machine id, cpu type, amount of memory and kernel
command line). No other information (especially about any device
detected in the system) is provided.

The proposed device-table approach for Samsung SoC is just the other
(imho more convenient and more powerful) way of defining the platform
devices and their resources for the Samsung integrated peripherals.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
