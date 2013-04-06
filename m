From: dt.tangr@gmail.com (Daniel Tang)
Date: Sat, 6 Apr 2013 11:26:19 +1100
Subject: [RFC PATCH arm: initial TI-Nspire support]
In-Reply-To: <201304041112.25780.arnd@arndb.de>
References: <6FE4B33E-A503-4A75-AEED-831CB2C06D83@gmail.com>
 <201304041112.25780.arnd@arndb.de>
Message-ID: <8FB21B56-58BC-4530-8C7A-71A32856210D@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

First of all, thank you for your comments!

On 04/04/2013, at 10:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> For new platforms, we want to have only the absolute minimum amount of
> code in arch/arm and move everything else into drivers. However, that
> is only possible using device tree. It should not add any significant
> complexity to your code, and you can easily bundle the device tree blob
> with the kernel.

Given that most of your comments described some very fundamental changes (esp switching to DTB) to the structure of our port, we've decided we'll probably start from scratch and fix the issues you outlined as we reimplement our platform.

At the moment, we're working on getting a basic DTB-booting kernel working so our next patch will be starting from basics.

Cheers,
tangrs
