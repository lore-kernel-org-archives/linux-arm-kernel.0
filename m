From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Tue, 07 Sep 2010 03:40:46 +0200
Subject: [RFCv5 0/9] CMA + VCMM integration
In-Reply-To: <20100906210905.GB5863@kroah.com>
References: <cover.1283749231.git.mina86@mina86.com>
	<20100906210905.GB5863@kroah.com>
Message-ID: <op.vim2x8i87p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 06 Sep 2010 23:09:05 +0200, Greg KH <greg@kroah.com> wrote:

> On Mon, Sep 06, 2010 at 08:33:50AM +0200, Michal Nazarewicz wrote:
>> Hello everyone,
>>
>> This patchset introduces a draft of a redesign of Zach Pfeffer's
>> VCMM.
>
> What is a VCMM?

Virtual Contiguous Memory Manager.  The version posted by Zach can
be found at: <http://article.gmane.org/gmane.linux.kernel.mm/50090>.
It is an API for managing IO MMU and IO MMU mappings.

> What is a CMA?

Contiguous Memory Manager.  The v4 version can be found at
<http://marc.info/?l=linux-mm&m=128229799415817&w=2>.  It is an API for
allocating large, physically contiguous blocks of memory.

I haven't expected that anyone who haven't already participated in the
discussion about CMA and VCMM will get interested by this patchset
so I was a bit vague in the cover letter.  Sorry about that.

>> Not all of the functionality of the original VCMM has been
>> ported into this patchset.  This is mostly meant as RFC.  Moreover,
>> the code for VCMM implementation in this RFC has not been tested.

> If you haven't even tested it, why should we review it?

Ignore the code then and look just at the documentation, please.
I wanted to post what I have to receive comments about the general
idea and not necessarily the code itself.  Code is just a mean to show
how I see the implementation of the idea described in the documentation.
Because of all that, I marked the patchset as a RFC rather than a PATCH.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
