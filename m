From: horms@verge.net.au (Simon Horman)
Date: Tue, 5 Jan 2016 07:31:37 +1100
Subject: [PATCH v2] ARM: shmobile: alt: Add QSPI device to DT
In-Reply-To: <CAMuHMdVFC1TEeTT5Gas8jz0Tvn2HB3EHBo7gp6pthsnOo6x5UQ@mail.gmail.com>
References: <1451903819-19218-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVFC1TEeTT5Gas8jz0Tvn2HB3EHBo7gp6pthsnOo6x5UQ@mail.gmail.com>
Message-ID: <20160104203136.GB12748@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 12:15:10PM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 4, 2016 at 11:36 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Enable the QSPI controller in the alt device tree.
> >
> > Based similar work for the silk board by by Vladimir Barinov and
> > Sergei Shtylyov.
> >
> > Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.6.

Should we document "spansion,s25fl512s" for the benefit of checkpatch.pl?
