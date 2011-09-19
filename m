From: albert.arquer@gmail.com (albert)
Date: Mon, 19 Sep 2011 07:45:57 +0000 (UTC)
Subject: Freescale i.mx25 SDIO/Libertas issue
References: <4DE2F84D.8080907@bluewatersys.com>
	<BANLkTi=GSw5HRdiqPB=JcgB9SyEhB1b79A@mail.gmail.com>
Message-ID: <loom.20110919T094146-623@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I used this Marvel WiFi 8686 in our previous product powered by i.MX51
> and it worked fine. You need to load the firmware before using it.
> Just put your binaries inside firmware directory on linux kernel and
> setup your kernel config:
> 
>  CONFIG_FW_LOADER=y
>  CONFIG_FIRMWARE_IN_KERNEL=y
> -CONFIG_EXTRA_FIRMWARE=""
> +CONFIG_EXTRA_FIRMWARE="sd8686_helper.bin sd8686.bin"
> +CONFIG_EXTRA_FIRMWARE_DIR="firmware"
> 
> Best Regards,
> 
> Alan
> 

Hi Alan, just a quick question. I am fairly new to all this linux embedded world.
I just wandered what this code you wrote actually does. I searched around and I 
understand that it plugs some extra firmware into the kernel at compiling time, 
however I don't really understand what "firmware" really means in this case. 

I mean, does it mean the driver itself? because I though all you had to do to 
include a driver into the kernel was put the source codes in the "/drivers" 
directory in the kernel's directory and modify a bit the makefile so that it is 
compiled.. is this not right?

Thanks for your time ;)
