From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Feb 2015 12:32:43 -0200
Subject: imx_v6_v7_defconfig needs lzop
In-Reply-To: <CAMuHMdVjqp52BQqH32Ut7kxDYzmyY4+JEVuhXgTqU8V24kQyZA@mail.gmail.com>
References: <CAMuHMdVjqp52BQqH32Ut7kxDYzmyY4+JEVuhXgTqU8V24kQyZA@mail.gmail.com>
Message-ID: <CAOMZO5Dh0Wv61Y0J_Ue1G=Y8vc23yM2Fxq6CqhpmNBHa-2Lkvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 4, 2015 at 12:21 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> http://kisskb.ellerman.id.au/kisskb/buildresult/12358024/
>
> /bin/sh: 1: lzop: not found
> cat: write error: Broken pipe
> make[3]: *** [arch/arm/boot/compressed/piggy.lzo] Error 1

Isn't this error happening due to the lack of 'lzop' package installed
on the host machine?
