From: broonie@kernel.org (Mark Brown)
Date: Fri, 10 Aug 2018 17:29:20 +0100
Subject: [PATCH v9 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <acfc014f3ae3d7feea30be6beaec3e64d96a2723.1531531808.git.collinsd@codeaurora.org>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <acfc014f3ae3d7feea30be6beaec3e64d96a2723.1531531808.git.collinsd@codeaurora.org>
Message-ID: <20180810162920.GG20971@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 06:50:59PM -0700, David Collins wrote:

> +	switch (rpmh_mode) {

> +	default:
> +		mode = REGULATOR_MODE_INVALID;
> +	}

I'm not sure why the break statements are being omitted in default
cases, but I do find myself stopping and trying to figure it out?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180810/9f783c72/attachment.sig>
