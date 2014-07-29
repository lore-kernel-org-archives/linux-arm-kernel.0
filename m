From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Jul 2014 19:25:24 +0100
Subject: [RFC 2/5] regulator: core: Allow to get voltage count and list
 from parent
In-Reply-To: <1406651339-28901-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
 <1406651339-28901-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140729182524.GZ17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 06:28:56PM +0200, Javier Martinez Canillas wrote:
> Load switches are modeled as regulators but they just provide
> the voltage of their parent input supply. So, the drivers for
> these switches usually neither provide a .list_voltage handler
> not set a .n_voltages count. But there is code in the kernel
> that assumes that all regulators should be able to provide this
> information (e.g: cpufreq and mmc subsystems).

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/4ee88451/attachment.sig>
