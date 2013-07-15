From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 Jul 2013 09:59:53 +0200
Subject: [PATCH 0/4] A10S-OLinuXino-Micro I2C support
In-Reply-To: <1373232719-13050-1-git-send-email-emilio@elopez.com.ar>
References: <1373232719-13050-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130715075953.GA2962@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Sun, Jul 07, 2013 at 06:31:55PM -0300, Emilio L?pez wrote:
> Hi,
> 
> This patchset adds the required DT nodes to get I2C supported and 
> working on the OLIMEX A10S-OLinuXino-Micro board.
> 
> Patch 1 adds the muxings as seen on the board's schematics. Patch 2 adds 
> the DT nodes, based on other sunxi dts, as we don't have an A10S user 
> manual so far. Patch 3 enables the controllers, and patch 4 adds a node 
> for the AT24 EEPROM found on the board.
> 
> I have tested and can see the PMU on I2C-0 using i2cdetect, and can read 
> the EEPROM contents on I2C-1. I have not tested I2C-2, but i2cdetect 
> reports no devices so I suppose it's working okay too.
> 
> Any testing or review will be appreciated :)

I just applied them to my sunxi/dt-for-3.12 branch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130715/9a977471/attachment.sig>
