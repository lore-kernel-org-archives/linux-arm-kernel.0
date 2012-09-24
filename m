From: stigge@antcom.de (Roland Stigge)
Date: Mon, 24 Sep 2012 22:03:11 +0200
Subject: [PATCH] gpio-lpc32xx: Fix value handling of
 gpio_direction_output()
In-Reply-To: <CACRpkdZo5kR+Tyhos_StEFZbw3WHF_RFRknHjtU2Pz4XpFTZCA@mail.gmail.com>
References: <1348130883-11329-1-git-send-email-stigge@antcom.de>
 <CACRpkdZo5kR+Tyhos_StEFZbw3WHF_RFRknHjtU2Pz4XpFTZCA@mail.gmail.com>
Message-ID: <5060BC7F.2030501@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/09/12 21:55, Linus Walleij wrote:
>> For GPIOs of gpio-lpc32xx, gpio_direction_output() ignores the value argument
>> (initial value of output). This patch fixes this by setting the level
>> accordingly.
>>
>> Signed-off-by: Roland Stigge<stigge@antcom.de>
>
> Applied with Alexandre's ACK, should go into stable right?
> So tagging this with Cc: stable and sending for the -rc:s.

Right, thanks!

Roland
