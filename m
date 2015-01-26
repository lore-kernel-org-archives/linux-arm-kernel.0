From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jan 2015 15:10:13 +0900
Subject: [PATCH 11/13] Documentation: Remove ZBOOT MMC/SDHI utility and
 docs
In-Reply-To: <CAMuHMdVy=28VAbiH3763UzA4qJ7qUOAJzFT7fv6GQfXq5-kLuQ@mail.gmail.com>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <20150121045447.7648.23274.sendpatchset@little-apple>
 <CAMuHMdVy=28VAbiH3763UzA4qJ7qUOAJzFT7fv6GQfXq5-kLuQ@mail.gmail.com>
Message-ID: <CANqRtoQfNAXoKgTTUm9=_8iU1vLOgbjNQ35HFHGOKCT4M3tJXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Wed, Jan 21, 2015 at 7:40 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Wed, Jan 21, 2015 at 5:54 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> --- 0001/Documentation/arm/Makefile
>> +++ work/Documentation/arm/Makefile     2015-01-21 11:27:40.337571523 +0900
>> @@ -1 +1 @@
>> -subdir-y := SH-Mobile
>> +
>
> .git/rebase-apply/patch:14: new blank line at EOF.
>
> This file can just be removed, if you remove the "arm" from
> Documentation/Makefile?

Thanks, I agree. I've done exactly that in V2.

Cheers,

/ magnus
