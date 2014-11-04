From: horms@verge.net.au (Simon Horman)
Date: Tue, 4 Nov 2014 09:11:26 +0900
Subject: [PATCH 0/2] ARM: shmobile: r8a7790: Fix SD3CKCR address
In-Reply-To: <CAMuHMdWS1M24vngxvrf3mRGfVwKvmgsXnqZ6xq_hJuPC=KqqWQ@mail.gmail.com>
References: <1414648677-31104-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWS1M24vngxvrf3mRGfVwKvmgsXnqZ6xq_hJuPC=KqqWQ@mail.gmail.com>
Message-ID: <20141104001125.GB20174@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 10:51:56AM +0100, Geert Uytterhoeven wrote:
> On Thu, Oct 30, 2014 at 6:57 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > This short series corrects the SD3CKCR address in both C and DT
> >
> > Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
> >
> > Shinobu Uehara (2):
> >   ARM: shmobile: r8a7790: Fix SD3CKCR address
> >   ARM: shmobile: r8a7790: Fix SD3CKCR address to device tree
> 
> This  matches my copy of the datasheet, so

Mine too :)

> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> But it would be good to know this has been verified on actual hardware.

As these came from the BSP my assumption is that they have
been verified on actual hardware. I will queue up these changes.
