From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 Oct 2015 18:56:18 +0100
Subject: [PATCH] ARM: sun7i: dt: Enable audio codec on pcDuino V3 Nano
In-Reply-To: <1445639787-23715-1-git-send-email-ats@offog.org>
References: <1445639787-23715-1-git-send-email-ats@offog.org>
Message-ID: <20151027175618.GD6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 23, 2015 at 11:36:27PM +0100, Adam Sampson wrote:
> The pcDuino V3 Nano has a 3.5mm TRRS jack socket for audio, using the
> CTIA standard pinout, connected to HPOUTL, HPOUTR, HPCOM/HPCOMFB and
> MICIN1/VMIC (via appropriate RC networks) on the A20. The PH00 GPIO is
> wired for headphone plug detection: it reads 0 when nothing's plugged
> in, and 1 when a plug is inserted.
> 
> LINEINL/R and FMINL/R are not connected.

Ah, so there's a design out there with headphone detect. Cool :)

Do you feel like writing the headphone detection code?

Anyway, queued for 4.5, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151027/2bba340d/attachment.sig>
