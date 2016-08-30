From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 30 Aug 2016 17:29:08 +0200
Subject: [PATCH v3 01/13] ARM: dts: lager: rename and reindex i2cexio
In-Reply-To: <1466567031-20381-2-git-send-email-horms+renesas@verge.net.au>
References: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
 <1466567031-20381-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160830151819.GA1695@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

>  		serial0 = &scif0;
>  		serial1 = &scifa1;
> -		i2c8 = "i2cexio";
> +		i2c10 = "i2cexio0";

Those should be pointers, i.e. "&i2cexio0;", here and in the rest of
your series. Sorry for the broken template! Did you have a chance to
test my fix for the demuxer?

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160830/6e38476e/attachment.sig>
