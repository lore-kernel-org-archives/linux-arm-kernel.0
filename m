From: broonie@kernel.org (Mark Brown)
Date: Wed, 21 Oct 2015 13:28:43 +0100
Subject: [PATCH] ASoC: dt-bindings: Drop unneeded properties rockchip
 i2s/spdif bindings
In-Reply-To: <1445242539-9098-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1445242539-9098-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <20151021122843.GD8232@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 10:15:39AM +0200, Sjoerd Simons wrote:
> Neither the rockchip i2s nor the rockchip spdif binding support child
> devices so #address-cells and #size-cells properties aren't required.
> Remove these from the bindings.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Please use subject lines matching the style for the subsystem!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151021/e1f4def2/attachment-0001.sig>
