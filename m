From: weitway@gmail.com (Jason Chen)
Date: Thu, 14 Apr 2011 20:37:04 +0800
Subject: [PATCH 5/7] ARM i.MX53 loco: Add framebuffer support
In-Reply-To: <20110414091220.GA7285@pengutronix.de>
References: <1302710016-3569-1-git-send-email-weitway@gmail.com>
	<1302710016-3569-5-git-send-email-weitway@gmail.com>
	<20110414085714.GY7285@pengutronix.de>
	<33F32152BE7EC740BC2C838D2836AC8710FD9C@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110414091220.GA7285@pengutronix.de>
Message-ID: <BANLkTinrw1JcFOx-7LYyATPQ08y9Lg0YVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/14 Sascha Hauer <s.hauer@pengutronix.de>:
> Please do not top post!
>
> On Thu, Apr 14, 2011 at 09:01:37AM +0000, Chen Jie-B02280 wrote:
>> Hi, Sascha,
>>
>> I tested this patch on wvga lcd panel for loco board.
>>
>> You can not get vga output if without tve driver support, I am planning upstream tve driver later.
>>
>> And how do you test HDMI on loco board? Do you get hdmi daughter card?
>
> Yes, I have the hdmi daughter board. I don't have the wvga lcd panel
> though. Shouldn't you register the mode for the wvga panel then?
> Also, Please don't register the second head when it's not actually
> working.
I am using VESA mode for wvga panel, and for hdmi, it also need one
driver to support.
>
> Sascha
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
