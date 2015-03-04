From: rockford@yandex.ru (=?koi8-r?B?8MHOz9cg4c7E0sXK?=)
Date: Wed, 04 Mar 2015 23:32:38 +0300
Subject: [PATCH] ARM: i.MX6Q: Add fixup for RTL8211E Gigabit Ethernet PHY
In-Reply-To: <CAOMZO5C+uyfi=Br8kj5zE1ik=qxk2h4vaQn1Loo9=Uv_WGaoQg@mail.gmail.com>
References: <1425404579-30591-1-git-send-email-rockford@yandex.ru>
 <3988965.hS0GXm2TNL@wuerfel> <4686121425496122@web26g.yandex.ru>
 <2796821.5chD2g3yoZ@wuerfel> <4971421425499543@web17m.yandex.ru>
 <CAOMZO5C+uyfi=Br8kj5zE1ik=qxk2h4vaQn1Loo9=Uv_WGaoQg@mail.gmail.com>
Message-ID: <5019881425501158@web17m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



04.03.2015, 23:18, "Fabio Estevam" <festevam@gmail.com>:
> On Wed, Mar 4, 2015 at 5:05 PM, ????? ?????? <rockford@yandex.ru> wrote:
>> ?Actually, I don't know. I've discovered this when I wanted to boot a more recent kernel
>> ?on this board, and network wasn't working. So I've had to disassembly a vendor's binary only module
>> ?to discover how they handle this situation.
>
> Do you use the generic PHY driver or do you have CONFIG_REALTEK_PHY enabled?

CONFIG_REALTEK_PHY=y
CONFIG_FIXED_PHY=y

> In case you use the realtek PHY driver and still see the issue, can't
> you fix this in drivers/net/phy/realtek.c instead?

I think there it will require a more work with board detection than here and will
populate a driver with unnecessary for most users code.


--
 ??????
