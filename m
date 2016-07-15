From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Jul 2016 13:56:43 +0100
Subject: [PATCH 0/4] Qualcomm IPQ4019 Audio driver addition
In-Reply-To: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
References: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
Message-ID: <20160715125643.GK30372@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2016 at 12:37:02PM +0530, njaigane at codeaurora.org wrote:
> From: Jaiganesh Narayanan <njaigane@codeaurora.org>
> 
> These patches add the support for Qualcomm IPQ4019 ASoC
> with the ALSA based audio drivers. The patches are broken
> 
> 1. Device Tree support
> 2. Audio clock driver support
> 3. TLMM / Pinctrl support
> 4. ALSA based audio drivers

You need to completely rework how you're posting this so it can be
reviewed, probably splitting it into separate patch serieses - please
see SubmittingPatches for an overview of what people are expecting, and
as I said in reply to one of the patches looking at git can also be
helpful.  I'd suggest sending the drivers for each subsystem as a
separate patch series, there will be some interdependency in terms of
getting things running but not in terms of getting the patches applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/d217733d/attachment-0001.sig>
