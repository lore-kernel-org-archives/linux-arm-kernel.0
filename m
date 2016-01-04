From: horms@verge.net.au (Simon Horman)
Date: Tue, 5 Jan 2016 07:39:05 +1100
Subject: [PATCH v2 0/3] ARM: shmobile: r8a779x: use fallback usbhs
 compatibility string
In-Reply-To: <CAMuHMdUALH_FQvOVH77V5JC3d4n7444zTh2VU-MEsOoKymFSDg@mail.gmail.com>
References: <1451856019-4222-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUALH_FQvOVH77V5JC3d4n7444zTh2VU-MEsOoKymFSDg@mail.gmail.com>
Message-ID: <20160104203904.GC12748@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 09:39:17AM +0100, Geert Uytterhoeven wrote:
> On Sun, Jan 3, 2016 at 10:20 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > this short series makes use of the recently added fallback usbhs
> > compatibility string in the r8a779[014] device trees.
> >
> > Based on renesas-devel-20151228-v4.4-rc7.
> >
> > Changes since v1:
> > * Use "renesas,rcar-gen2-usbhs" instead of "renesas,usbhs"
> >
> > Simon Horman (3):
> >   ARM: shmobile: r8a7790: use fallback usbhs compatibility string
> >   ARM: shmobile: r8a7791: use fallback usbhs compatibility string
> >   ARM: shmobile: r8a7794: use fallback usbhs compatibility string
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued these up for v4.6.
