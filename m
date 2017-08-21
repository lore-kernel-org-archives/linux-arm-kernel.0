From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 21 Aug 2017 10:25:23 +0200
Subject: [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
In-Reply-To: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
References: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170821082523.GA2418@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>  	  Below is the number clocks for each supported SoC:
> -	   1: SH73A0, R8A73A4, R8A7740, R8A7778, R8A7779, R8A7790
> -	      R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
> +	   1: SH73A0, R8A73A4, R8A7740, R8A7743, R8A7745, R8A7778, R8A7779,
> +	      R8A7790, R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
>  	   2: R7S72100

Hmm, maybe we should convert this to only listing SoCs with two clocks?
That will be easier to maintaine since the majority seems to have one.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/024ba7bd/attachment.sig>
