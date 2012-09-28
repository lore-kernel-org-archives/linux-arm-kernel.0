From: stigge@antcom.de (Roland Stigge)
Date: Fri, 28 Sep 2012 14:35:04 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <CACRpkdbEgBqSdZmebw+PBMo9G_Y24mgz17=dp11VrbKf5fKyDQ@mail.gmail.com>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <CACRpkdZ+1ffsMDRZXYb5RRndoXstj_QHvHOpeikRY0bas72dKQ@mail.gmail.com>
 <50657356.4010801@antcom.de>
 <CACRpkdbEgBqSdZmebw+PBMo9G_Y24mgz17=dp11VrbKf5fKyDQ@mail.gmail.com>
Message-ID: <50659978.8010003@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/28/2012 01:34 PM, Linus Walleij wrote:
>> Or some kind of new character device node?
> 
> Yes, I don't know if we should create /dev/gpioN or /dev/pinctrlN for
> this, and add GPIO functions to pinctrl (while wrapping it in the
> gpiolib to aid migration) the latter would encourage users of the
> new ABI to switch to writing pinctrl drivers.

Will have a look at this.

>> Otherwise, I need to think about leaving out the sysfs for this purpose.
> 
> Do you really need it?

In more that half of the cases, I needed userspace access. So I'm quite
interested in it.

Thanks for your notes.

Roland
