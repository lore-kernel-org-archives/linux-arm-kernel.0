From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 28 May 2012 14:18:18 +0300
Subject: [RFC PATCH 08/11] ARM: OMAP4+: Adding the temperature sensor
 register set bit fields
In-Reply-To: <CAMQu2gweS9O7+n3_J=7W3CeDOBgMML+z+BXKafqChhEZd3bmDQ@mail.gmail.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-9-git-send-email-eduardo.valentin@ti.com>
 <CAMQu2gweS9O7+n3_J=7W3CeDOBgMML+z+BXKafqChhEZd3bmDQ@mail.gmail.com>
Message-ID: <20120528111818.GE3923@besouro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 03:34:28PM +0530, Shilimkar, Santosh wrote:
> On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
> > OMAP4460 specific temperature sensor register bit fields are added.
> > Existing OMAP4 entries are renamed to OMAP4430.
> >
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> > ---
> Once you split the header, as mentioned in earlier comment,
> you can move those defines in driver file directly.

Agreed, this patch is gonna be dropped and the definition will be part of patch introducing the bandgap driver

> 
> Regards
> Santsoh
