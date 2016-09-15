From: rdunlap@infradead.org (Randy Dunlap)
Date: Thu, 15 Sep 2016 08:01:54 -0700
Subject: linux-next: Tree for Sep 15 (phy/phy-meson-usb2.c)
In-Reply-To: <20160915165008.40acdecf@canb.auug.org.au>
References: <20160915165008.40acdecf@canb.auug.org.au>
Message-ID: <d8adb2cf-ac81-7bf7-8dae-aca9475fe736@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/16 23:50, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20160914:
> 

on x86_64:

drivers/built-in.o: In function `phy_meson_usb2_probe':
phy-meson-usb2.c:(.text+0x350c): undefined reference to `of_usb_get_dr_mode_by_phy'


when CONFIG_USB_SUPPORT is not enabled.

-- 
~Randy
