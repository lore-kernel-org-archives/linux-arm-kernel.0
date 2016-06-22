From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 22 Jun 2016 14:54:07 +0200
Subject: [PATCH] ARM: tegra: import latest Jetson TK1 spreadsheet
In-Reply-To: <20160621185149.20625-1-swarren@wwwdotorg.org>
References: <20160621185149.20625-1-swarren@wwwdotorg.org>
Message-ID: <20160622125407.GI26943@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 12:51:49PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This imports v11 of "Jetson TK1 Development Platform Pin Mux" from
> https://developer.nvidia.com/embedded/downloads.
> 
> The new version defines the mux option for the MIPI pad ctrl selection.
> The OWR pin no longer has an entry in the configuration table because
> the only mux option it support is OWR, that feature isn't supported, and
> hence can't conflict with any other pin. This pin can only usefully be
> used as a GPIO.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160622/9b665570/attachment.sig>
