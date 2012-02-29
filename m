From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 29 Feb 2012 21:43:49 +0800
Subject: [Linaro-mm-sig] [PATCHv23 00/16] Contiguous Memory Allocator
In-Reply-To: <op.wafz3gv53l0zgt@mpn-glaptop>
References: <1329929337-16648-1-git-send-email-m.szyprowski@samsung.com>
 <CAGsJ_4wgVcVjtAa6Qpki=8jSON7MfwJ8yumJ1YXE5p8L3PqUzw@mail.gmail.com>
 <op.wafuu3kr3l0zgt@mpn-glaptop>
 <CAGsJ_4yk+Ca4RDP=sYaXvEKuJzYNhyZWQ7jfKnpR+zCm=3Dq6Q@mail.gmail.com>
 <op.wafz3gv53l0zgt@mpn-glaptop>
Message-ID: <CAGsJ_4zYttky4+FbzmmaPzQ4b3HwjnpwhX_vE7My9J=ytm20RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/29 Michal Nazarewicz <mina86@mina86.com>:
> On Wed, 29 Feb 2012 14:34:02 +0100, Barry Song <21cnbao@gmail.com> wrote:
>
>> 2012/2/29 Michal Nazarewicz <mina86@mina86.com>:
>>>
>>> On Wed, 29 Feb 2012 10:35:42 +0100, Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> and i also write a simple kernel helper to test the CMA:
>
>
>>> Would it make sense to make a patch out of it putting it to tools/cma (or
>>> similar)?
>
>
>> i can send a patch for this. i am just thinking, should it be placed
>> in tools/ as a test utility or Documents/ as an example to explain CMA
>> to users who want to use cma.
>
>
> I'd put it in tools/.

ok. i will handle this.

>
>
>> i also think we should have a seperate document to explain cma in details
>> in documents/, and my helper program can be placed there.
>
>
> I'm currently writing an article for LWN which I hope will also lead to
> something
> worth putting in Documentation/.
>

fine.

>
> --
> Best regards, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? _ ? ? _
> .o. | Liege of Serenely Enlightened Majesty of ? ? ?o' \,=./ `o
> ..o | Computer Science, ?Micha? ?mina86? Nazarewicz ? ?(o o)
> ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--

-barry
