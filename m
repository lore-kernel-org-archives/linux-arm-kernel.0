From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 21 Aug 2017 13:33:39 +0200
Subject: [PATCH v2] mmc: renesas_sdhi: Add r8a7743/5 support
In-Reply-To: <1503311897-18807-1-git-send-email-biju.das@bp.renesas.com>
References: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
 <1503311897-18807-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170821113339.GA3790@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -	  Below is the number clocks for each supported SoC:
> -	   1: SH73A0, R8A73A4, R8A7740, R8A7778, R8A7779, R8A7790
> -	      R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
> -	   2: R7S72100
> +	  Most supported SoCs only have 1 clock. Devices which have more
> +	  than 1 clock are listed below:
> +	  2: R7S72100"

I like this, but stray " at the end of the line?

With that fixed:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/c86ac8bf/attachment.sig>
