From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 18 Aug 2016 15:35:08 +0200
Subject: [PATCH 1/2] ARM: dts: rockchip: remove excess sd properties for
 firefly reload
In-Reply-To: <1471453391-10267-2-git-send-email-ayaka@soulik.info>
References: <19126716.OZv44ZHtAK@diego>
 <1471453391-10267-1-git-send-email-ayaka@soulik.info>
 <1471453391-10267-2-git-send-email-ayaka@soulik.info>
Message-ID: <49067977.DDSr6TXKjU@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 18. August 2016, 01:03:10 schrieb Randy Li:
> Because of a bug in hardware design, the sdcard at firefly
> rk3288 reload board can't switch the io voltage level to 1.8v.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>

applied to my dts32 branch for 4.9

In the future, please try to base your patches either on the correct dts 
branch in my repo [0] or simply on linux-next which does contain these too,
as I did reorder some things when applying your initial firefly-reload patch.


Thanks
Heiko


[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/
[dts patches v4.x-armsoc/dts32 and v.x-armsoc/dts64 depending on what board 
you're working on]
