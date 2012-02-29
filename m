From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 29 Feb 2012 12:43:41 +0100
Subject: [Linaro-mm-sig] [PATCHv23 00/16] Contiguous Memory Allocator
In-Reply-To: <CAGsJ_4wgVcVjtAa6Qpki=8jSON7MfwJ8yumJ1YXE5p8L3PqUzw@mail.gmail.com>
References: <1329929337-16648-1-git-send-email-m.szyprowski@samsung.com>
 <CAGsJ_4wgVcVjtAa6Qpki=8jSON7MfwJ8yumJ1YXE5p8L3PqUzw@mail.gmail.com>
Message-ID: <op.wafuu3kr3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Feb 2012 10:35:42 +0100, Barry Song <21cnbao@gmail.com> wrote:

> 2012/2/23 Marek Szyprowski <m.szyprowski@samsung.com>:
>> This is (yet another) quick update of CMA patches. I've rebased them
>> onto next-20120222 tree from
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git and
>> fixed the bug pointed by Aaro Koskinen.
>
> For the whole series:
>
> Tested-by: Barry Song <Baohua.Song@csr.com>
>
> and i also write a simple kernel helper to test the CMA:

Would it make sense to make a patch out of it putting it to tools/cma (or similar)?

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
