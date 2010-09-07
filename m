From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Tue, 07 Sep 2010 03:58:50 +0200
Subject: [RFCv5 8/9] mm: vcm: Sample driver added
In-Reply-To: <20100906211054.GC5863@kroah.com>
References: <cover.1283749231.git.mina86@mina86.com>
	<262a5a5019c1f1a44d5793f7e69776e56f27af06.1283749231.git.mina86@mina86.com>
	<20100906211054.GC5863@kroah.com>
Message-ID: <op.vim3scj57p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 06 Sep 2010 23:10:54 +0200, Greg KH <greg@kroah.com> wrote:

> On Mon, Sep 06, 2010 at 08:33:58AM +0200, Michal Nazarewicz wrote:
>> --- /dev/null
>> +++ b/include/linux/vcm-sample.h
>
> Don't put "sample" code in include/linux/ please.  That's just
> cluttering up the place, don't you think?  Especially as no one else
> needs the file there...

Absolutely true.  My plan is to put a real driver in place of the sample
driver and post it with v6.  For now I just wanted to put a piece of code
that will look like a driver for presentation purposes.  Sorry for the
confusion.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
