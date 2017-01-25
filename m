From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jan 2017 12:04:13 +0100
Subject: [PATCH v2 4/6] ARM: tegra: nyan-blaze: Include compatible
 revisions for proper detection
In-Reply-To: <20170122154753.31942-4-contact@paulk.fr>
References: <20170122154753.31942-1-contact@paulk.fr>
 <20170122154753.31942-4-contact@paulk.fr>
Message-ID: <20170125110413.GE9344@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 04:47:51PM +0100, Paul Kocialkowski wrote:
> Depthcharge (the payload used with cros devices) will attempt to detect
> boards using their revision. This includes all the known revisions for
> the nyan-blaze board so that the dtb can be selected preferably.
> 
> Defining compatibly revisions allows depthcharge to select the kernel
> via the revision it detects instead of using the default kernel. This
> allows having a FIT image with multiple kernels for multiple devices.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/tegra124-nyan-blaze.dts | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Applied, with the same padding adjustments as 3/6.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/90b79ae5/attachment.sig>
