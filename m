From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 24 Nov 2013 21:00:49 +0000
Subject: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
In-Reply-To: <20131121131402.GF1029@lukather>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <528DF164.8060009@st.com> <20131121131402.GF1029@lukather>
Message-ID: <52926901.9080004@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/21/13 13:14, Maxime Ripard wrote:
> Hi Denis,
> 
> On Thu, Nov 21, 2013 at 12:41:24PM +0100, Denis CIOCCA wrote:
>> only one point: it's possible to use the same names with DT? (using _ instead of -)
> 
> Yes, it is, but only for i2c as far as I'm aware, and usually the DT compatibles are with - as a separator (I
> looked into the ePAPR, but couldn't get any explanations or requirements on this, even though it's used in all of
> their examples)
In other discussions, where the defacto i2c device tree bindings have
been followed, the conclusion has been that to change to a - from _
would result in userspace ABI changes, so whilst no one wants _
the discussion has concluded we can't really avoid it.


> 
>> Why only for i2c?
> 
> Because I was only interested in i2c :)
> 
> Maxime
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSkmkBAAoJEFSFNJnE9BaI9mgP/A0TrsoGuLmu1Zc0R2Y2QkY/
wE4hrQrB0uGwD6TE+dXCuJVmHLqA7KviGN3l4sJPgo8kGAEsAItow8XoOPZFE8sU
w9hXVU+0UXOiMmQIf/5bTvVpBV7oL6agYpQQkb8ZIHKZCj5gd588sc+Ag90Uc+lK
MiI1QsvLbS8O1tZui+4NlkaioUQs5rs0OvD9N1n+aCfSdgsZk1NMR97Xf5Hwpmbj
ypTokNVAClZd8dyrq9KHXfR6+qPwI9Pr/yA5nqZvpV++SiqlFw5nWAR/URPp/rEE
czT8ZiC2SR5qRTVb+jRCj4hY8QmLIfeZEqrsZab9CkRkEmeMgQ8FhpBe+a1Zk1YS
ZojKQS4rJzjuJukuq4vs/R8jPhwAIxguzzC7rA/UNtyYUvqTrIcXBRzFxRp6BHtv
PO2viO773gvni3C6qzFtLBcYfJUBD6VNi440yHDxMSZY5gJl3auHdIzpTxN30aQG
P4l347YqfsvrEpiG7gN2B5ScQ3WwGXBpfomke1dkuDElZZ7vgV/MAE7Hjh/uKCfg
0lLzoBWdO72faznHCm8tOOPAQcSqXAm0F4BHQENeVirieZN2mS4EhS0xmN1fCdOy
5PeN424FSGw6LUgAZd8R45/usPzzlDKTQ2rf0nBZIRdxYmyocg2ZUCINI6OxJThn
OJkKZAsuvBdhsqSSAx+C
=xwmo
-----END PGP SIGNATURE-----
