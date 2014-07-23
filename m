From: daniel@zonque.org (Daniel Mack)
Date: Wed, 23 Jul 2014 11:17:52 +0200
Subject: [PATCH] ARM: OMAP: generic: add call to of_clk_init()
In-Reply-To: <20140723085444.GC22006@atomide.com>
References: <1405162508-9835-1-git-send-email-zonque@gmail.com>
 <20140723085444.GC22006@atomide.com>
Message-ID: <53CF7DC0.3000006@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 07/23/2014 10:54 AM, Tony Lindgren wrote:
> * Daniel Mack <zonque@gmail.com> [140712 03:57]:
>> This is needed to instanciate fixed clocks in the DT.
> 
> Makes sense to me. Does this fix some regression or hang
> that's needed for the -rc series?

No, it's a feature addition. No need to hurry :)

> Also would like to get an ack from Tero on this as the other
> clocks are initialized elsewhere.

Ok, thanks. I'm open to alternative ways of course.


Thanks,
Daniel
