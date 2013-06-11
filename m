From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Jun 2013 12:52:06 +0100
Subject: [PATCH 09/10] regulator: ab8500-ext: Enable for Device Tree
In-Reply-To: <1370621488-18130-10-git-send-email-lee.jones@linaro.org>
References: <1370621488-18130-1-git-send-email-lee.jones@linaro.org>
 <1370621488-18130-10-git-send-email-lee.jones@linaro.org>
Message-ID: <20130611115206.GA1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 05:11:27PM +0100, Lee Jones wrote:

> +static struct of_regulator_match ab8500_ext_regulator_match[] = {
> +	{ .name = "ab8500_ext1", .driver_data = (void *) AB8500_EXT_SUPPLY1, },
> +	{ .name = "ab8500_ext2", .driver_data = (void *) AB8500_EXT_SUPPLY2, },
> +	{ .name = "ab8500_ext3", .driver_data = (void *) AB8500_EXT_SUPPLY3, },
> +};

Should be a binding document update for these.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130611/f15e555a/attachment.sig>
