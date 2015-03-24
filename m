From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Mar 2015 15:37:45 -0700
Subject: [PATCH v3 2/9] regmap: Introduce regmap_get_reg_stride.
In-Reply-To: <1427236200-18625-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1427236116-18531-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1427236200-18625-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150324223745.GC28997@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 10:30:00PM +0000, Srinivas Kandagatla wrote:

> + /* regmap_get_reg_stride(): Report the register address stride
> + *
> + * Report the register address stride, mainly intended to for use by
> + * generic infrastructure built on top of regmap.
> + */
> +int regmap_get_reg_stride(struct regmap *map)

Please fix the indentation for the comment block and add kerneldoc for
the argument.  This is an exported function so it should also be /** not
/*
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/a37136bd/attachment-0001.sig>
