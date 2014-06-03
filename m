From: horms@verge.net.au (Simon Horman)
Date: Wed, 4 Jun 2014 08:29:06 +0900
Subject: [PATCH v2 0/7] ARM: shmobile: koelsch reference: Enable DMA for
 QSPI
In-Reply-To: <CAMuHMdVnmsjf29X4KF0co+WwUh9i0DQe6hE0hNFMCv-+GeHP_w@mail.gmail.com>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <538D50D1.7010900@renesas.com>
 <CAMuHMdVnmsjf29X4KF0co+WwUh9i0DQe6hE0hNFMCv-+GeHP_w@mail.gmail.com>
Message-ID: <20140603232906.GC19407@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 09:05:42AM +0200, Geert Uytterhoeven wrote:
> On Tue, Jun 3, 2014 at 6:36 AM, Khiem Nguyen
> <khiem.nguyen.xt@renesas.com> wrote:
> > I think this patch series should be divided into 2 parts,
> > one for DMA in general and one for DMA supporting QSPI.
> >
> > How do you think about it ?
> 
> I don't think it's worth splitting off just the last patch into a separate
> series.
> 
> This is a series, not a single patch. The applyer can always drop some
> patches.

FWIW, that seems reasonable to me.
