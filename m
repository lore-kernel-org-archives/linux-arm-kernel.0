From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Fri, 12 Sep 2014 20:14:46 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAyLzRdIEFSTTogZHRzOiBwYmFiMDE6IGVuYWJsZSBJ?=
 =?UTF-8?B?MlMgYXVkaW8gb24gcGh5RkxFWC1pLk1YNiBib2FyZHM=?=
In-Reply-To: <1410537872-17274-3-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410537872-17274-3-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <1410538486.406482403@f174.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fri, 12 Sep 2014 19:04:30 +0300 ?? Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>:
> Audio on phyFLEX boards is presented by tlv320aic3007 codec connected
> over SSI interface.
> 
> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
> ---
...
> +&audmux {
> +	status = "okay";
> +
> +	ssi2 {
> +		fsl,audmux-port = <1>;
> +		fsl,port-config = <0xa5000000 0x00008000>;
> +	};
> +	pins5 {
> +		fsl,audmux-port = <4>;
> +		fsl,port-config = <0x00000000 0x00002000>;
> +	};
> +};

You should use defines from sound/fsl-imx-audmux.h for audmux.

---
