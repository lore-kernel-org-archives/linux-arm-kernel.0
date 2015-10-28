From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 28 Oct 2015 07:20:38 +0100
Subject: [PATCH] ARM: dts: sunxi: sun6i-a31s-primo81.dts: add touchscreen
 axis swapping property
In-Reply-To: <1445720851-2148-1-git-send-email-merker@debian.org>
References: <20151024205716.GA16644@excalibur.cnev.de>
 <1445720851-2148-1-git-send-email-merker@debian.org>
Message-ID: <20151028062038.GF6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 24, 2015 at 11:07:31PM +0200, Karsten Merker wrote:
> The MSI Primo81 has a display in portrait mode but a touchscreen
> in landscape mode.  To have both of them use the same coordinate
> system, the touchscreen-swapped-x-y property has to be set
> for the touchscreen.
> 
> Signed-off-by: Karsten Merker <merker@debian.org>

Queued as a fix for 4.4.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151028/4946fbaa/attachment.sig>
