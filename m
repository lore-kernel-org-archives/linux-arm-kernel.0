From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Tue, 30 Sep 2014 14:13:35 +0200
Subject: [PATCH] spi: bcm53xx: add BCMA dependency
In-Reply-To: <3256402.M8e92DFkbg@wuerfel>
References: <3256402.M8e92DFkbg@wuerfel>
Message-ID: <CACna6ryoq0A_6745aemJPQTEZxncmDRkCOPB3ZUHtNhXqXf2Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2014 14:09, Arnd Bergmann <arnd@arndb.de> wrote:
> The BCMA bus framework can be disabled on bcm53xx, which leads to a link
> error when building the SPI driver:

You missed this one:
https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/commit/?h=for-next&id=933fc7b06ca62741fd5067edab13068d13b3cb35
