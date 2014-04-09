From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Apr 2014 17:35:34 +0100
Subject: Big endian working?
In-Reply-To: <CAA3XUr2QQy_cy6yP19HWNxCcwPbY9FUi9VAZj7easz+HkLZa+A@mail.gmail.com>
References: <20140408095446.0520dd28@skate>
 <CAA3XUr3gR-R1X6+CxP-Z0fv7kiSzENtm0NsYd539BNVWKCgdNw@mail.gmail.com>
 <53450D3A.7030909@linaro.org> <4880190.MJBhke5aDa@wuerfel>
 <CAA3XUr2QQy_cy6yP19HWNxCcwPbY9FUi9VAZj7easz+HkLZa+A@mail.gmail.com>
Message-ID: <534576D6.4060003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/14 17:17, Victor Kamensky wrote:
> On 9 April 2014 02:38, Arnd Bergmann <arnd@arndb.de> wrote:
>> For BE8, I think we should just try to do the right thing before
>> we see mass deployments of broken boot loaders.
> 
> Agreed. For any BE work we've done it was stated that
> it should work with regular LE bootloaders. In fact any system
> should be able to switch between LE and BE images without
> any other changes, not even bootloader setting or variable.

Yup.

And from a slightly different perspective, kvmtool has no idea whether
it is booting a BE or LE guest, and I'd very much like to keep it
blissfully unaware.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
