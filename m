From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 7 Jun 2017 19:52:20 +0200
Subject: [PATCH v2 0/3] Add R8A7743/SK-RZG1M PFC support
In-Reply-To: <4937ae78-8800-1a11-547b-2269d063d45a@cogentembedded.com>
References: <20170420185132.258111787@cogentembedded.com>
 <20170424061217.GC14843@verge.net.au>
 <4937ae78-8800-1a11-547b-2269d063d45a@cogentembedded.com>
Message-ID: <CAMuHMdUDO-+F_fOf4Z1ZPdZhs_MBn8J6ig-Pn4K0oMvv-EM2gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Jun 7, 2017 at 6:16 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 04/24/2017 09:12 AM, Simon Horman wrote:
>
>>>    Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
>>> 'renesas-devel-20170420-v4.11-rc7' tag.  We're adding the R8A7743 PFC
>>> node
>>> and then describing the pins for SCIF0 and Ether devices declared
>>> earlier.
>>> These patches depend on the R8A7743 PFC suport in order to work properly.
>>
>>
>> Thanks. I have marked these as deferred pending acceptance of the PFC
>> driver changes. Please repost or otherwise let me know when dependency
>> is satisfied.
>
>    FYI, Linus W. has pulled the R8A774x PFC patches for 4.13:
>
> https://www.spinics.net/lists/linux-renesas-soc/msg14824.html

But Simon has to wait for v4.13-rc1 to apply the DTS parts, to avoid
regressions in renesas/devel.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
