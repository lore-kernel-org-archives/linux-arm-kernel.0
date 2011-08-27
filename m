From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Sat, 27 Aug 2011 10:37:32 +0530
Subject: [PATCH] mtd: Replace DEBUG with MTD_DBG
In-Reply-To: <CAN8TOE9ACmLyZFkPp9FJ4j59hSeHtLmUqYv39z3NW70M16muGQ@mail.gmail.com>
References: <CAMPhdO_qVn8JaX6orfnHHXjmi8pTQFb1SzMe2RQM9xMdTvimaQ@mail.gmail.com>	<1314335775-3384-2-git-send-email-tanmay.upadhyay@einfochips.com>
	<CAN8TOE9ACmLyZFkPp9FJ4j59hSeHtLmUqYv39z3NW70M16muGQ@mail.gmail.com>
Message-ID: <4E587B94.7090003@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 26 August 2011 09:40 PM, Brian Norris wrote:
> On Thu, Aug 25, 2011 at 10:16 PM, Tanmay Upadhyay
> <tanmay.upadhyay@einfochips.com>  wrote:
>> Defining macro 'DEBUG' for debug prints conflicts with other
>> subsystem where defining 'DEBUG' means enable debug code including
>> debug prints and others. So, replaced DEBUG with MTD_DBG for MTD
> DEBUG was killed from MTD recently in the subsystem tree for MTD,
> l2-mtd-2.6.git:
> git://git.infradead.org/users/dedekind/l2-mtd-2.6.git
>
> The fix *should* be merged in the next merge window, so this patch is
> unnecessary.
>
> Brian
>

Thanks for the information. Glad to see pr_debug replacing DEBUG. :)

Regards,
Tanmay
