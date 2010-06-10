From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 9 Jun 2010 23:01:18 -0500
Subject: [PATCH 09/10] omap: mailbox: convert block api to kfifo
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA4D88F3@dlee06.ent.ti.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1275546858-29507-10-git-send-email-Hiroshi.DOYU@nokia.com>
	<D2943F03B81C9C458E44DFB213905E02B6325C6A@dlee04.ent.ti.com>
	<AANLkTik4lW3_xP_e4BStJEYpHlVoNjemEz8zWfIE7gRU@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602CA4D88F3@dlee06.ent.ti.com>
Message-ID: <AANLkTik8I7NXU-rdKeUfNToBOPLs2WneoBTtgHiYF_WJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 9, 2010 at 12:38 AM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>>From: Ohad Ben-Cohen [ohad at wizery.com]
>>But now that you point me to this irq on/off thing, it looks a bit
>>broken in terms of multiple concurrent mbox support since it relies on
>>a global rq_full state. I guess it'd be better to hold that rq_full
>>state in the relevant mbox queue state itself.
>
> Yes, you are right Ohad. Only should be disable the "new message" interrupt of the mailbox which kfifo is full.


Great! do you plan to submit a fix to patch 05/10 then ?

Thanks,
Ohad.

>
> regards,
> Fernando.
>
>>
>>Thanks,
>>Ohad.
>
