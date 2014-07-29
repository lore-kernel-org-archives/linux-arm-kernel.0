From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Jul 2014 18:20:05 +0100
Subject: [RFC 5/5] ARM: dts: Improve Peach Pit and Pi power scheme model
In-Reply-To: <1406651339-28901-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
 <1406651339-28901-6-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140729172005.GW17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 06:28:59PM +0200, Javier Martinez Canillas wrote:
> The DeviceTree files for the Peach Pit and Pi machines have
> a simplistic model of the connections between the different
> regulators since not all the tps65090 regulators get their
> input supply voltage from the VDC. DCDC1-3, LD0-1 and fet7
> parent supply is indded VDC but the fet1-6 get their input
> supply from the DCDC1 and DCDC2 output voltage rails.

Acked-by: Mark Brown <broonie@linaro.org>

This *should* be independent of the rest of this series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/374fee28/attachment-0001.sig>
