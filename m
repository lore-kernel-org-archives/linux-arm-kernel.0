From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jan 2015 18:13:30 +0900
Subject: [PATCH 00/13] ARM: shmobile: Remove sh7372/Mackerel and ZBOOT
 MMC/SDHI support
In-Reply-To: <CAMuHMdWax_yWKVn-j2UF1ZUB-LvFEFmo-KJ+kQ0Qr2gTHro8gw@mail.gmail.com>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <87twzkn1rd.wl%kuninori.morimoto.gx@renesas.com>
 <CAMuHMdWoi1TDq-XQO6-EjVzQPyYyeG4e0U+chseQ9MXuO3Lhgg@mail.gmail.com>
 <CANqRtoRj0Ssyc6ONkw05pUadzA8G5agqi3uWi7o_-hhYEs64Eg@mail.gmail.com>
 <CAMuHMdWax_yWKVn-j2UF1ZUB-LvFEFmo-KJ+kQ0Qr2gTHro8gw@mail.gmail.com>
Message-ID: <CANqRtoRi05hNqjBj4Mu0tCJxqOrGBnKPg8V5LZ9tXQr4GzXnDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 5:20 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Jan 26, 2015 at 7:47 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> It seems arch/sh still supports Linux running on the SH core in sh7372?
>>
>> I don't think we have any support upstream for that, but I recall
>> cooking up some prototype running two linux instances in separate
>> memory spaces and using virtio as mailbox interface in between. I also
>> recall that SH4AL-DSP CPU core tend to be a PITA to handle
>> toolchain-wise, but SH4 with FPU is much easier with current (or
>> yesteryear) toolchain. Exactly which SH core that is included in
>> sh7372 I'm not so sure about. =)
>
> JFTR, SH4AL-DSP.

Good luck with that. =)

/ magnus
