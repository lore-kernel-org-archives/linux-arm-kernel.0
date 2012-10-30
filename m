From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 30 Oct 2012 18:14:41 +0100
Subject: [PATCH 1/5] ARM: at91: atmel-ssc: add platform device id table
In-Reply-To: <20121030160722.GW4511@opensource.wolfsonmicro.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
 <20121030160722.GW4511@opensource.wolfsonmicro.com>
Message-ID: <50900B01.3000402@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/30/2012 05:07 PM, Mark Brown :
> On Mon, Oct 22, 2012 at 06:17:55PM +0800, Bo Shen wrote:
>> Using platform device id to check whether the Atmel SOC support
>> dma for data transfer
>> 
>> If match "at91rm9200_ssc" which does not support DMA transfer If
>> match "at91sam9g45_ssc" which support DMA transfer
> 
> Any comments on this from that Atmel folks?  If I don't see
> something I'll probably just apply.

Indeed, comment sent.

Thanks for the "heads-up" Mark.

Best regards,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQEcBAEBAgAGBQJQkAr2AAoJEAf03oE53VmQviMIAJrjBBi3ePMgP+jwRQuKw54A
bZOHRmaqpGPh6cLAvXeUEkv2VflLcoYxIKiV1PZsNYctUHz/rrYX4y5bMwkJqJb1
jWR1LDibKWny74pXiilrf4pgtabqhIQN8v64DjIg4vF8I6pzBBtlA3sBBQtRlJzB
yQulBHP63vNDHlZm+AayeuWkF16Gh+FfDtYSNDy8w8lNjJLwQo2mNvI6WurSTI85
mqidOzW5k0wrYo/6012vAzIV3BC+1Ck0A2gXhkS8yhuThS1xT+u4c3iTAMJE2FzZ
PM4+JLf0o5fgtOkj0UzFuVea6BxNQ/qjwyV6y+cJ/QBS7DY7N9rmD+vrr8dpgMs=
=wvcs
-----END PGP SIGNATURE-----
