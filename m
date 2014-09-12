From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 12 Sep 2014 20:26:01 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAyLzRdIEFSTTogZHRzOiBwYmFiMDE6IGVuYWJsZSBJ?=
 =?UTF-8?B?MlMgYXVkaW8gb24gcGh5RkxFWC1pLk1YNiBib2FyZHM=?=
In-Reply-To: <1410537872-17274-3-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410537872-17274-3-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <1410539161.314611261@f174.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fri, 12 Sep 2014 19:04:30 +0300 ?? Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>:
> Audio on phyFLEX boards is presented by tlv320aic3007 codec connected
> over SSI interface.
> 
> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
> ---
...
> +&ssi2 {
> +	fsl,mode = "i2s-slave";
> +	status = "okay";
> +	#sound-dai-cells = <0>;
> +};

I have already sent patch to add "#sound-dai-cells" into all i.MX DT-files.
Shawn, can you point us to this tree/commit?

---
