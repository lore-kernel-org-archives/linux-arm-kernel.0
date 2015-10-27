From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 Oct 2015 19:27:06 +0100
Subject: [PATCH] ASoC: sun4i-codec: use consistent names for PA controls
In-Reply-To: <1445688712-31951-1-git-send-email-ats@offog.org>
References: <1445688712-31951-1-git-send-email-ats@offog.org>
Message-ID: <20151027182706.GE6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 24, 2015 at 01:11:52PM +0100, Adam Sampson wrote:
> The power amplifier for the headphone output is called "the PA" and "the
> headphone amplifier" in Allwinner's documentation for the A10 and A20.
> sun4i-codec calls it "PA" in some places and "Pre-Amplifier" (which
> isn't really accurate) in others, leading to user-visible controls with
> different names referring to the same device.
> 
> When this driver implements audio input, it'll also need to expose
> controls for the line and mic input preamps, so just referring to "the
> Pre-Amplifier" will be ambiguous.
> 
> Change it to use "PA" consistently for the power amplifier.

Just to avoid any ambiguity in the future, could you call that Power
Amp(lifier?) instead?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151027/210773a6/attachment.sig>
