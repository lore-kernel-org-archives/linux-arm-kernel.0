From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 31 Mar 2014 13:02:55 +0200
Subject: [PATCH 1/2] ARM: sun7i/sun6i: dts: Fix IRQ number for sun6i NMI
 controller
In-Reply-To: <1395939759-11135-2-git-send-email-carlo@caione.org>
References: <1395939759-11135-1-git-send-email-carlo@caione.org>
 <1395939759-11135-2-git-send-email-carlo@caione.org>
Message-ID: <20140331110255.GE26751@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 06:02:38PM +0100, Carlo Caione wrote:
> From: Hans de Goede <hdegoede@redhat.com>
> 
> The IRQ line used in sun6i-a31.dtsi for the NMI controller is wrong.
> This causes a IRQ storm since the NMI controller is repeatedly fired.
> This patch fixes this problem assigning the correct IRQ number to the
> NMI controller.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Carlo Caione <carlo@caione.org>

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
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140331/ce3c2f12/attachment-0001.sig>
