From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 17 Dec 2012 12:09:35 +0100
Subject: [PATCH] ASoC: atmel-ssc: change disable to disable in dts node
In-Reply-To: <20121215145145.GE22033@opensource.wolfsonmicro.com>
References: <1355364307-31584-1-git-send-email-voice.shen@atmel.com>
 <20121215145145.GE22033@opensource.wolfsonmicro.com>
Message-ID: <50CEFD6F.3070703@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/15/2012 03:51 PM, Mark Brown :
> On Thu, Dec 13, 2012 at 10:05:07AM +0800, Bo Shen wrote:
>> Change the value of status to disabled to keep the consistent
>> 
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> 
> Applied, thanks.

Hi Mark,

While rebasing this patch (for the other open question that we have
about ssc pinctrl), I discovered that the subject of this patch is
nonsense (same with the message, BTW).

So I rewrote the subject and comment and will submit a new patch
series soon with this content included. So it will be good if you can
replace this patch with the one in the series that I have just prepared.

As said in the other message, the new series is based on top of
current Linus' git tree. In fact, the pinctrl related material is
better merged now that the pinctrl tree for 3.8 is included in mainline.

I hope that it makes sense for you ;-)

Thanks for your patience Mark, bye,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQEbBAEBAgAGBQJQzv1oAAoJEAf03oE53VmQEV0H+PDv7MmVEBy3oFoouQ+yowtv
m6wzh4smEk2BRGWOBV2cXf56CZTakG5ntJmrPLwyXoJ4bt2mC73RAN1DWMuN24Uk
Vu3gyPQJDOAT2G4jq8b6fjstrjzXa7FbauWX0lNXFc0IUEp4/aX2z82ioK6JKwhW
JMG77G3yX4jX9GLNES5+ZI8nztXPZ8xAANynXYhadhHCx0TNo81SK/ohut9Xg5gB
4jYoybhuIymsG8ZYVz9edULLd48VngN25+f27n6Y3uTqvGGZg8ndYEkwMFkqwxKS
v4RLq1dptq1Z2HNJJCr36hkPdvKT93QcxNm/8Vr82nJUHoqJMXqtef8rkPNgSA==
=cE8U
-----END PGP SIGNATURE-----
