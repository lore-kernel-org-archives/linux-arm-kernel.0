From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 7 Apr 2016 14:28:43 +0200
Subject: [RFC6 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <20160406122924.GA21527@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <CAMuHMdUUkaYVZ3-Jh6o1b++R=yFBg7siQt+A+TqqXRSa953CAw@mail.gmail.com>
 <20160406122924.GA21527@yury-N73SV>
Message-ID: <CAMuHMdVTw=UjRZqJZCj=OS4SzrFt22SVaC39ePYC_1THZzX1Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 6, 2016 at 2:29 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>> We're already closer to the (future) y2038 than to the (past) introduction of
>> LP64...
>
> This is not about Y2038 at all. In fact, current version doesn't fix
> Y2038 problem, as we decided finally.

Indeed. So these legacy applications have to be fixed later anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
