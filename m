From: horms@verge.net.au (Simon Horman)
Date: Thu, 11 Dec 2014 09:32:34 +0900
Subject: [PATCH] ARM: shmobile: lager: Fix QSPI mode of SPI-Flash into
 mode3
In-Reply-To: <CAMuHMdXv-12uVasSkLQs6gPYgfaS+O+dBQvDyCswDCTuffvp7g@mail.gmail.com>
References: <1418178627-24424-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXv-12uVasSkLQs6gPYgfaS+O+dBQvDyCswDCTuffvp7g@mail.gmail.com>
Message-ID: <20141211003233.GC513@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 11:11:01AM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 10, 2014 at 3:30 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
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
