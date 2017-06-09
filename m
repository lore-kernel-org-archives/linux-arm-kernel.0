From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Jun 2017 15:58:17 +0200
Subject: [linux-sunxi] [PATCH] arm64: allwinner: sun50i-a64: Remove
 duplicate ethernet@1c30000
In-Reply-To: <6d21516d-7412-5f16-f6f8-b7d46106b4f5@arm.com>
References: <1497012052-14027-1-git-send-email-jteki@openedev.com>
 <6d21516d-7412-5f16-f6f8-b7d46106b4f5@arm.com>
Message-ID: <20170609135817.wntaqkbekiagq45e@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 02:38:39PM +0100, Andre Przywara wrote:
> Hi,
> 
> On 09/06/17 13:40, Jagan Teki wrote:
> > From: Jagan Teki <jagan@amarulasolutions.com>
> > 
> > Remove duplicate ethernet at 1c30000 from allwinner/sun50i-a64.dtsi
> 
> I think this is an artefact of the sun8i-dwmac merging, where both David
> and Maxime merged the DT patches in their trees (compare e53f67e9 and
> 103aefa0). I think both of them are in the process of sorting this out
> (as this effects more than this hunk, I believe).

Yeah, hopefully we'll manage to fix this.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/f19d7f79/attachment.sig>
