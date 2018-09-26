From: horms@verge.net.au (Simon Horman)
Date: Wed, 26 Sep 2018 12:32:05 +0200
Subject: [PATCH/RFT] arm64: dts: renesas: r8a77965: Add Sound and Audio
 DMAC device nodes
In-Reply-To: <20180924122624.gnrhlwfeik5ki2zf@verge.net.au>
References: <1532551190-14797-1-git-send-email-ykaneko0929@gmail.com>
 <20180924122624.gnrhlwfeik5ki2zf@verge.net.au>
Message-ID: <20180926103204.rdzr5mnioo7ijc27@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 02:26:25PM +0200, Simon Horman wrote:
> On Thu, Jul 26, 2018 at 05:39:50AM +0900, Yoshihiro Kaneko wrote:
> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > 
> > Based on a similar patch of the R8A7796 device tree
> > by Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>.
> > 
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > ---
> > 
> > The following patches were squashed into this patch:
> > 
> >   arm64: dts: r8a77965: Add Audio-DMAC device nodes
> >   arm64: dts: r8a77965: Add Sound device node and SSI support
> >   arm64: dts: r8a77965: Add Sound SRC support
> >   arm64: dts: r8a77965: Add Sound DVC device nodes
> >   arm64: dts: r8a77965: Add Sound CTU support
> >   arm64: dts: r8a77965: Add Sound MIX support
> > 
> > This patch is based on the devel branch of Simon Horman's renesas tree.
> > 
> >  arch/arm64/boot/dts/renesas/r8a77965.dtsi | 245 ++++++++++++++++++++++++++++--
> >  1 file changed, 234 insertions(+), 11 deletions(-)
> 
> I have tested playback and record using a loopback cable and this patce
> appears to work well on top of a merge of:
> 
> * renesas-devel-20180919-v4.19-rc4
> * renesas-drivers-2018-09-11-v4.19-rc3
> 
> I plan to accept this patch for v4.20 in the coming days if there are no
> objections.

I have now applied this for v4.20.

> Tested-by: Simon Horman <horms+renesas@verge.net.au>

Testing was on a Salvator-XS board.
