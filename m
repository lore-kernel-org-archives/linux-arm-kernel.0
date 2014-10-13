From: viric@viric.name (=?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell)
Date: Mon, 13 Oct 2014 17:48:07 +0200
Subject: Regarding tx-nocache-copy in the Sheevaplug
In-Reply-To: <1413211759.9362.103.camel@edumazet-glaptop2.roam.corp.google.com>
References: <20141013105246.GD1972@vicerveza.homeunix.net>
 <20141013142156.GE26864@lunn.ch>
 <20141013143138.GJ1972@vicerveza.homeunix.net>
 <1413211759.9362.103.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <20141013154807.GN1972@vicerveza.homeunix.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 13, 2014 at 07:49:19AM -0700, Eric Dumazet wrote:
> On Mon, 2014-10-13 at 16:31 +0200, Llu?s Batlle i Rossell wrote:
> > Enabling tx offload and disabling tx-nocache-copy, making the machine *send* a
> > lot of ssh traffic (sftp for example) makes ssh fail HMAC. It's quite easy to
> > reproduce here.
> > 
> > As for the hardware, it's an old sheevaplug board.
> 
> 
> Have you tried disabling TSO only, and are you using the latest kernel ?
> 
> Ezequiel Garcia added lot of changes recently.
> 
> 

Is TSO TCP segmentation offload? It's disabled. The kernel is 3.16.3 (debian).
https://packages.debian.org/testing/kernel/linux-image-3.16-2-kirkwood
