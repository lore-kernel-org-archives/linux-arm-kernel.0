From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 1 Nov 2015 10:36:25 +0100
Subject: [PATCH v2] ASoC: sun4i-codec: use consistent names for PA controls
In-Reply-To: <1445979645-1664-1-git-send-email-ats@offog.org>
References: <1445979645-1664-1-git-send-email-ats@offog.org>
Message-ID: <20151101093625.GO6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Tue, Oct 27, 2015 at 09:00:45PM +0000, Adam Sampson wrote:
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
> Change it to use "Power Amplifier" consistently for the power
> amplifier's controls.
> 
> Signed-off-by: Adam Sampson <ats@offog.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151101/f97a20c7/attachment.sig>
