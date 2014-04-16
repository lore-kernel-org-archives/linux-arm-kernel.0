From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Wed, 16 Apr 2014 21:29:19 +0100
Subject: [PATCH v4 13/21] misc: support for LP-8x4x custom parallel bus
In-Reply-To: <6356054.sn5XpK65Cm@wuerfel>
References: <1397668411-27162-7-git-send-email-ynvich@gmail.com>
 <1397668667-27328-7-git-send-email-ynvich@gmail.com>
 <20140416194109.3ef914d2@alan.etchedpixels.co.uk>
 <6356054.sn5XpK65Cm@wuerfel>
Message-ID: <20140416212919.7f6f35ac@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Apr 2014 20:42:39 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 16 April 2014 19:41:09 One Thousand Gnomes wrote:
> > On Wed, 16 Apr 2014 21:17:18 +0400
> > Sergei Ianovich <ynvich@gmail.com> wrote:
> > 
> > > This patch implements probing for the bus and reporting the number
> > > of available expansion slots.
> > 
> > This appears to be a bus not a misc device. I don't think it belongs in
> > misc. As you've got devices on this bus (or nailed into the 'bus' driver)
> > perhaps this belongs as drivers/platform/lp8x4x or similar with any
> > specific drivers split out - or even drivers/lp8x4x if there will be more
> > of them and more than one platform using it ?
> 
> We have drivers/bus now, I think it could fit well in there.

Agreed
