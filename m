From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 May 2014 17:45:20 -0500
Subject: [PATCH v10 15/15] ARM: dts: sun7i: Add basic support for the
 Cubietruck WiFi module
In-Reply-To: <1399046249-19472-16-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-16-git-send-email-hdegoede@redhat.com>
Message-ID: <20140505224520.GB9464@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 02, 2014 at 05:57:29PM +0200, Hans de Goede wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The CubieTruck has an AMPAK AP6210 WiFi+Bluetooth module. The WiFi
> part is a BCM43362 IC connected to MMC3 in the A20 SoC via SDIO.
> The IC also takes a power enable signal via GPIO.
> 
> The WiFi module supports out-of-band interrupt signaling via GPIO,
> but this is not supported in this patch.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied with Chen-Yu SoB.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140505/ad667316/attachment.sig>
