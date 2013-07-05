From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 5 Jul 2013 09:38:07 +0200
Subject: [PATCH 0/3] Added support for On Chip OTP in i.MX23/28
In-Reply-To: <1372855154-8422-1-git-send-email-cb@sgoc.de>
References: <1372855154-8422-1-git-send-email-cb@sgoc.de>
Message-ID: <20130705073807.GE2959@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoph,

On Wed, Jul 03, 2013 at 02:39:11PM +0200, Christoph G. Baumann wrote:
> From: "Christoph G. Baumann" <cb@sgoc.de>
> 
> This patch contains the ported driver from Freescale for the On Chip OTP
> cells in the i.MX23 and i.MX28. The OTP cells can be read and written via
> files in /sys/fsl_otp.
> 
> Christoph G. Baumann (3):
>   Added support for On Chip OTP in i.MX23/28
>   Added support for On Chip OTP in i.MX23/28
>   Added support for On Chip OTP in i.MX23/28

You should use better commit logs here. There's no way to get what each
patch actually does from only looking at those lines.

You should probably have something like:
  misc: Add Freescale mxs On Chip OTP driver
  ARM: mxs: dt: Enable the OTP in the DTSI
  ...

This has two advantages: the review is easier since the reviewer
actually knows what each patch is doing and what to review, and most of
all, you get a cleaner and more complete history, so that in a few
month/years, you can get (ideally) all the context of this patch and
what it's actually doing without having to look into the code.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130705/bf3a310e/attachment.sig>
