From: horms@verge.net.au (Simon Horman)
Date: Fri, 22 Apr 2016 10:14:58 +1000
Subject: [PATCH v3] PCI: rcar-pcie: Remove Gen2 designation from Kconfig
In-Reply-To: <CAMuHMdXtVvNERECxbp1EtJ1SNOQG-j_xtV3NpsGqgyDLmc7cOg@mail.gmail.com>
References: <1461210715-29304-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXtVvNERECxbp1EtJ1SNOQG-j_xtV3NpsGqgyDLmc7cOg@mail.gmail.com>
Message-ID: <20160422001455.GA25416@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2016 at 03:38:35PM +0200, Geert Uytterhoeven wrote:
> On Thu, Apr 21, 2016 at 5:51 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > It appears that Gen2 is a misnomer for the R-Car PCIE driver
> > which also supports Gen 1 and Gen 3 SoCs. Accordingly, drop Gen 2
> > from the help text and Kconfig symbol.
> >
> > Also, re-arange the Kconfig symbol name to use PCIE as the prefix.
> > This appears to be in keeping with other PCIE Kconfig symbols.
> >
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
