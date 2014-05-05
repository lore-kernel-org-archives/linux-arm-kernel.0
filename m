From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 4 May 2014 23:02:12 -0500
Subject: [PATCH v10 15/15] ARM: dts: sun7i: Add basic support for the
 Cubietruck WiFi module
In-Reply-To: <1399046249-19472-16-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
 <1399046249-19472-16-git-send-email-hdegoede@redhat.com>
Message-ID: <20140505040212.GC11606@lukather>
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

It doesn't have Chen-Yu SoB. Chen-Yu, are you fine with adding it?

No need to respin the set, I'll add it when applying if it's ok.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140504/cade465f/attachment.sig>
