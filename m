From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jan 2017 12:09:33 +0100
Subject: [PATCH v2 6/6] ARM: tegra: nyan-blaze: Proper pinmux for TPM i2c
In-Reply-To: <20170122154753.31942-6-contact@paulk.fr>
References: <20170122154753.31942-1-contact@paulk.fr>
 <20170122154753.31942-6-contact@paulk.fr>
Message-ID: <20170125110933.GG9344@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 04:47:53PM +0100, Paul Kocialkowski wrote:
> From: Jerome Coste <jerome.coste@etu.utc.fr>
> 
> This corrects the pinmux for accessing the TPM over the i2c line.
> Thus, it allows correctly probing the module, that previously failed with i2c
> errors.

This is missing a Signed-off-by: from Jerome and you (since you
forwarded the patch). I've added those since I assume that that was
intended and your both willing to provide it.

Other than that, same substitution for "i2c" -> "I2C" as on 5/6, and
please also make sure this change gets into the pinmux configurations.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/c9b564c3/attachment-0001.sig>
