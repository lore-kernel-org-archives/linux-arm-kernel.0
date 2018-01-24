From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 24 Jan 2018 12:46:26 +0100
Subject: [v2,2/5] i2c: meson: add configurable divider factors
In-Reply-To: <600c932f-59d6-d7ec-ec02-b92b275049d5@amlogic.com>
References: <20171120145415.6581-3-yixun.lan@amlogic.com>
 <20180124062830.vi52rtlgglryq3xz@ninjato>
 <600c932f-59d6-d7ec-ec02-b92b275049d5@amlogic.com>
Message-ID: <20180124114626.mfckwbcacoyjzsin@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> but, I didn't get this build warnings while test locally, so is there
> any specific compiler option that I need to pass to?

I used "W=1 C=1" when compiling. My gcc version is:

(Debian 6.3.0-18) 6.3.0 20170516

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180124/ce69e414/attachment.sig>
