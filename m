From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jan 2017 12:06:44 +0100
Subject: [PATCH v2 5/6] ARM: tegra: nyan-big: Proper pinmux for TPM i2c
In-Reply-To: <20170122154753.31942-5-contact@paulk.fr>
References: <20170122154753.31942-1-contact@paulk.fr>
 <20170122154753.31942-5-contact@paulk.fr>
Message-ID: <20170125110644.GF9344@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 04:47:52PM +0100, Paul Kocialkowski wrote:
> This corrects the pinmux for accessing the TPM over the i2c line.
> Thus, it allows correctly probing the module, that previously failed with i2c
> errors.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/tegra124-nyan-big.dts | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

I've applied an s/i2c/I2C/ in the commit message and applied this. Can
you also make sure that these changes go into the nyan-big configuration
of the tegra-pinmux-scripts[0]? I know Stephen wants to keep those in
sync with the DTS.

Thanks,
Thierry

[0]: https://github.com/NVIDIA/tegra-pinmux-scripts
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/48b08ba2/attachment.sig>
