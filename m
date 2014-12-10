From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Dec 2014 09:26:22 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Fix QSPI mode of SPI-Flash into
 mode3
In-Reply-To: <CAMuHMdXj9N3tL_9ttw+jU7fxjC8x=JJwXQynMkjOAJp38=L4ww@mail.gmail.com>
References: <1418085432-20374-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXj9N3tL_9ttw+jU7fxjC8x=JJwXQynMkjOAJp38=L4ww@mail.gmail.com>
Message-ID: <20141210002622.GE9690@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 09:53:04AM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 9, 2014 at 1:37 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >
> > In order to change into mode3, CPOL and CPHA bit of SPCMD register
> > of QSPI is changed. Mode3 can avoid intermediate voltage.
> >
> > Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> > [horms: Updated changelog and re-ordered properties]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
