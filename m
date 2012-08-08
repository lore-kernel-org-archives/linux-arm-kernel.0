From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 8 Aug 2012 19:46:54 +0000
Subject: [rtc-linux] [PATCH 8/8] ARM: vt8500: gpio: Devicetree support
 for arch-vt8500
In-Reply-To: <CACRpkdabUWpDsBhz4ZEJNhEuqw-U+v-HrX7NcWoNLeuenv5t9A@mail.gmail.com>
References: <1344389967-8465-1-git-send-email-linux@prisktech.co.nz>
 <1344389967-8465-9-git-send-email-linux@prisktech.co.nz>
 <CACRpkdbYxpN9RCu8j8KMBgrb=-DsYZHq7hx-ifmHhJ0ZZcRYjw@mail.gmail.com>
 <201208080919.52592.arnd@arndb.de>,
 <CACRpkdabUWpDsBhz4ZEJNhEuqw-U+v-HrX7NcWoNLeuenv5t9A@mail.gmail.com>
Message-ID: <76F764B079F92A4E843589C893D0A022D1DCA8E3@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>This needs to be named something intuitive like "vt8500_gpio_bank_regoffsets"

>Some kerneldoc intsead of the opaque comment above will also improve
>readability a lot:

>/**
>  * struct vt8500_gpio_bank_regoffsets
>  * @en: offset to enable register in the bank
>  * ...

Changes made as requested.


>My feeling however is that the "vt8500_chip->regoff" is wrong, which
>would mean only the first bank works. The code adds the same offsets
>per bank once more that it sets in this bank table.

>        Arnd

Oh.. Thanks for picking that up Arnd. You are absolutely correct. I have removed
the references for ->regoff. Left over from old code.

Regards

Tony Prisk
