From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 26 Nov 2012 15:25:31 +0000
Subject: [PATCH 1/2] leds: Add generic support for memory mapped LEDs
In-Reply-To: <1353325492.3303.0.camel@hornet>
References: <1351792722-15250-1-git-send-email-pawel.moll@arm.com>
 <1352388952.20549.12.camel@hornet> <1353325492.3303.0.camel@hornet>
Message-ID: <1353943531.10271.4.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-19 at 11:44 +0000, Pawel Moll wrote:
> On Thu, 2012-11-08 at 15:35 +0000, Pawel Moll wrote:
> > Hi Bryan, Richard,
> > 
> > On Thu, 2012-11-01 at 17:58 +0000, Pawel Moll wrote:
> > > LEDs are often controlled by writing to memory mapped
> > > register. This patch adds:
> > > 
> > > 1. Generic functions for platform code and drivers to create
> > >    class device for LEDs controlled by arbitrary bit masks.
> > >    The control register value is read, modified by logic AND
> > >    and OR operations with respective mask and written back.
> > > 
> > > 2. A platform driver for simple use case when one or more LED
> > >    are controlled by consecutive bits in a register pointed
> > >    at by the platform device's memory resource. It can be
> > >    particularly useful for MFD cells being part of an other
> > >    device.
> > > 
> > > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > 
> > It's just a friendly and polite nag - any thoughts or feelings about
> > this?
> 
> Ping again?

And another polite nag for this week...

Pawe?
