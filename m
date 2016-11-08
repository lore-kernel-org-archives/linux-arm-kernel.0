From: minyard@acm.org (Corey Minyard)
Date: Tue, 8 Nov 2016 12:15:57 -0600
Subject: [PATCH 1/3] ipmi/bt-bmc: change compatible node to
 'aspeed,ast2400-ibt-bmc'
In-Reply-To: <a886778e-a85e-758e-3a61-c4909652e39d@kaod.org>
References: <1478073426-3714-1-git-send-email-clg@kaod.org>
 <CACPK8XcM1_xmmUu-cCZrSR67Y_qeXuSJ4Xmd_2gcgDT321LdBQ@mail.gmail.com>
 <ebeba60f-429f-fb84-b9da-c27d11d23094@kaod.org> <2368736.y6FyG1ESuP@wuerfel>
 <a886778e-a85e-758e-3a61-c4909652e39d@kaod.org>
Message-ID: <c749ff0a-bc71-bc9f-0e8c-326db2cea0fb@acm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2016 09:52 AM, C?dric Le Goater wrote:
> O
snip

>>>> While we're modifying the binding, should we add a compat string for
>>>> the ast2500?
>>> Well, if the change in this patch is fine for all, may be we can add
>>> the ast2500 compat string in a followup patch ?
>> Sounds good to me.
> OK. So, how do we proceed with this patch ? Who would include it in its
> tree ?

I don't have anything for 4.9 at the moment.  Arnd, if you have 
something, can
you take this?  Otherwise I will.

And I guess I should add:

Acked-by: Corey Minyard <cminyard@mvista.com>

-corey

> Thanks,
>
> C.
>
