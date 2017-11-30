From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 30 Nov 2017 16:07:17 +0000
Subject: [PATCH 2/2] pinctrl: sunxi: Disable strict mode for H5 driver
In-Reply-To: <CACRpkdZX5U=JoQFS+X96+F68yVSZbnCZpgNfAnvfJGxZ9moi8A@mail.gmail.com>
References: <20171125120200.23294-1-andre.przywara@arm.com>
 <20171125120200.23294-3-andre.przywara@arm.com>
 <CACRpkdZX5U=JoQFS+X96+F68yVSZbnCZpgNfAnvfJGxZ9moi8A@mail.gmail.com>
Message-ID: <3ef7cfa4-cc1a-f24b-0013-f36db82781e5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30/11/17 15:51, Linus Walleij wrote:
> On Sat, Nov 25, 2017 at 1:02 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> 
>> All of the H5 boards in the kernel reference the MMC0 CD pin twice in
>> their DT, so strict mode will make the MMC driver fail to load.
>> To keep existing DTs working, disable strict mode in the H5 driver.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> Reported-by: Chris Obbard <obbardc@gmail.com>
> 
> Patch applied with Maxime's ACK.

Thanks for that (also to Maxime and Chen-Yu) and the smooth handling!

Sorry, I just see that I didn't point this out explicitly, but this is
to fix a regression introduced in 4.15-rc1, so is this on a branch that
will be pushed for 4.15-rc, still? (Couldn't find anything quickly on
kernel.org)

Cheers,
Andre.
