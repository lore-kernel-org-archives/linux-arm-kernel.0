From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 09 Jan 2015 00:51:23 +0200
Subject: [PATCH v2 0/8] Add Simple Power-Managed Bus Support
In-Reply-To: <CAMuHMdVeEmKiqGTOmevaBDbJ=nBTbSi6d6Xrm0eyvbMTtyU=sA@mail.gmail.com>
References: <1418842153-17113-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdVeEmKiqGTOmevaBDbJ=nBTbSi6d6Xrm0eyvbMTtyU=sA@mail.gmail.com>
Message-ID: <10372546.9gL7hIlFWP@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Thursday 08 January 2015 20:28:45 Geert Uytterhoeven wrote:
> On Wed, Dec 17, 2014 at 7:49 PM, Geert Uytterhoeven wrote:
> > The Renesas Bus State Controller (BSC) provides an external bus for
> > connecting multiple external devices to an SoC, driving several chip
> > select lines, for e.g. NOR FLASH, Ethernet and USB.
> > On the kzm9g and ape6evm development boards, an smsc9220 Ethernet
> > controller is connnected to the BSC of an SH-Mobile AG5 (sh73a0) resp.
> > R-Mobile APE6 (r8a73a4) SoC.
> 
> [...]
> 
> > This was tested on sh73a0/kzm9g-multiplatform. Without this, Ethernet
> > doesn't work, as the ZB clock is disabled by clk_disable_unused().
> > Testing on r8a73a4/ape6evm-multiplatform would be appreciated.
> 
> Has anyone tried this on r8a73a4/ape6evm-multiplatform?

I'm afraid I can't help there, as I have no APE6EVM board.

-- 
Regards,

Laurent Pinchart
