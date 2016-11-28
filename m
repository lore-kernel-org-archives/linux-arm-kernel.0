From: horms@verge.net.au (Simon Horman)
Date: Mon, 28 Nov 2016 11:24:12 +0100
Subject: [PATCH renesas-next 1/3] ARM: dts: r8a73a4: Use SoC-specific
 compat string for mmcif
In-Reply-To: <CAMuHMdVGXQMRU-tn2EtrSAZXMLhBMNkHsxOtvUJ9duxR_Tnsxg@mail.gmail.com>
References: <1480018514-31718-1-git-send-email-horms+renesas@verge.net.au>
 <1480018514-31718-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVGXQMRU-tn2EtrSAZXMLhBMNkHsxOtvUJ9duxR_Tnsxg@mail.gmail.com>
Message-ID: <20161128102411.GA23112@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 09:58:40AM +0100, Geert Uytterhoeven wrote:
> On Thu, Nov 24, 2016 at 9:15 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Use the SoC-specific compat string for mmcif in DT for the r8a73a4 SoC.
> > This is in keeping with the use of compat strings for mmcif for other
> > Renesas ARM based SoCs.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued up this and the following two patches for v4.11.
