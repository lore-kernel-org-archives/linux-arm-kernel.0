From: stefan@agner.ch (Stefan Agner)
Date: Thu, 05 Feb 2015 22:28:48 +0100
Subject: =?UTF-8?Q?imx=5Fv=36=5Fv=37=5Fdefconfig=20needs=20lzop?=
In-Reply-To: <CAOMZO5Dh0Wv61Y0J_Ue1G=Y8vc23yM2Fxq6CqhpmNBHa-2Lkvg@mail.gmail.com>
References: <CAMuHMdVjqp52BQqH32Ut7kxDYzmyY4+JEVuhXgTqU8V24kQyZA@mail.gmail.com>
 <CAOMZO5Dh0Wv61Y0J_Ue1G=Y8vc23yM2Fxq6CqhpmNBHa-2Lkvg@mail.gmail.com>
Message-ID: <5d834be8e4f427e81493348279c36c4e@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-02-04 15:32, Fabio Estevam wrote:
> On Wed, Feb 4, 2015 at 12:21 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> http://kisskb.ellerman.id.au/kisskb/buildresult/12358024/
>>
>> /bin/sh: 1: lzop: not found
>> cat: write error: Broken pipe
>> make[3]: *** [arch/arm/boot/compressed/piggy.lzo] Error 1
> 
> Isn't this error happening due to the lack of 'lzop' package installed
> on the host machine?

Hm, interesting, why does this error not occur in the LZ4 case?
https://lkml.org/lkml/2015/2/2/669

--
Stefan
