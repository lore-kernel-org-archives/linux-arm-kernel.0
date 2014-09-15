From: d.lavnikevich@sam-solutions.net (Dmitry Lavnikevich)
Date: Mon, 15 Sep 2014 15:04:50 +0300
Subject: [PATCH v2 2/4] ARM: dts: pbab01: enable I2S audio on phyFLEX-i.MX6
 boards
In-Reply-To: <1410538486.406482403@f174.i.mail.ru>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410537872-17274-3-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410538486.406482403@f174.i.mail.ru>
Message-ID: <5416D5E2.5050109@sam-solutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/14 19:14, Alexander Shiyan wrote:
> Fri, 12 Sep 2014 19:04:30 +0300 ?? Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>:
>> +&audmux {
>> +	status = "okay";
>> +
>> +	ssi2 {
>> +		fsl,audmux-port = <1>;
>> +		fsl,port-config = <0xa5000000 0x00008000>;
>> +	};
>> +	pins5 {
>> +		fsl,audmux-port = <4>;
>> +		fsl,port-config = <0x00000000 0x00002000>;
>> +	};
>> +};
> You should use defines from sound/fsl-imx-audmux.h for audmux.
Ok, will change it in next patchset version.
