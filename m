From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri, 02 Mar 2012 16:44:48 +0100
Subject: [PATCH] MM: CMA: add a simple kernel module as the helper to test
 CMA
In-Reply-To: <CAGsJ_4zz=C2k3pvc=1_=iviSUkz78QCF+yumEEMaknysLHFxag@mail.gmail.com>
References: <1330656742-5233-1-git-send-email-Barry.Song@csr.com>
 <op.wajuip2a3l0zgt@mpn-glaptop>
 <CAGsJ_4zz=C2k3pvc=1_=iviSUkz78QCF+yumEEMaknysLHFxag@mail.gmail.com>
Message-ID: <op.wajvcyle3l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 2012/3/2 Michal Nazarewicz <mina86@mina86.com>:
>> Looks quite all right.  It has a race condition but I guess for a test
>> device it's not that big of a deal (I think the race cannot cause
>> panic).  Either way, would be nice if one could specify how much memory
>> device should allocate.  How about those changes: [...]

On Fri, 02 Mar 2012 16:37:46 +0100, Barry Song <21cnbao@gmail.com> wrote:
> Michal, I think these improvements have maken the cma_test much more
> useful and flexible.

Sure, no problem, just squash it and resend the patch and I'll take one more
look at the result. :)

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
