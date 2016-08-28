From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Sun, 28 Aug 2016 23:13:14 +0200
Subject: [PATCH 1/4] ARM: dts: Add TOPEET itop core board SCP package
 version
In-Reply-To: <1472383269-3126-2-git-send-email-ayaka@soulik.info>
References: <CAL_JsqKY=VEZ+U11kY+XbMWuXhaFDr6GpnR3AXKd1U=9_=8fgA@mail.gmail.com>
 <1472383269-3126-1-git-send-email-ayaka@soulik.info>
 <1472383269-3126-2-git-send-email-ayaka@soulik.info>
Message-ID: <20160828211314.nj2hxepxym3x3tee@vip.cybercity.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 28, 2016 at 07:21:06PM +0800, Randy Li wrote:

> +	s5m8767: s5m8767_pmic at 66 {
> +		compatible = "samsung,s5m8767-pmic";
> +		reg = <0x66>;

You shouldn't use underscores in node names.
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1122967.html
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg1145633.html

-- 
Rask Ingemann Lambertsen
