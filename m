From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Nov 2012 14:42:09 -0700
Subject: [PATCH 2/2] ARM: mmp: support pinctrl single in brownstone
In-Reply-To: <1353049345-6954-2-git-send-email-haojian.zhuang@gmail.com>
References: <1353049345-6954-1-git-send-email-haojian.zhuang@gmail.com>
 <1353049345-6954-2-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <50AAA7B1.7060404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 12:02 AM, Haojian Zhuang wrote:
> Support pinctrl-single driver in brownstone platform with DT.

> diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts

>  	chosen {
> -		bootargs = "console=ttyS2,38400 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on";
> +		bootargs = "console=ttyS2,38400 root=/dev/nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on earlyprintk";

That seems unrelated.
