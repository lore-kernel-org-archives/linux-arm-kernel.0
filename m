From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 3 Apr 2018 17:03:11 +0200
Subject: [PATCH v6 3/3] i2c: add param sanity check to i2c_transfer()
In-Reply-To: <20180325110747.8852-4-ard.biesheuvel@linaro.org>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180325110747.8852-4-ard.biesheuvel@linaro.org>
Message-ID: <20180403150311.7gpvcga33eivlyms@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	if (!msgs || num < 1)
> +		return -EINVAL;

I think this case justifies WARN (or WARN_ON, I always mix them up).

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/10dd1b75/attachment.sig>
