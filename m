From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Sep 2014 18:13:45 +0200
Subject: [PATCH v3 0/6] Migrate PXA27x platforms to clock framework
In-Reply-To: <20140903184956.11368.47800@quantum> (Mike Turquette's message of
 "Wed, 03 Sep 2014 11:49:56 -0700")
References: <1406753464-15000-1-git-send-email-robert.jarzmik@free.fr>
 <1465795.XsPpj3dZHX@wuerfel> <87d2bq43pc.fsf@free.fr>
 <201408241408.19861.arnd@arndb.de>
 <20140903184956.11368.47800@quantum>
Message-ID: <874mw2xoau.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Turquette <mturquette@linaro.org> writes:

> Quoting Arnd Bergmann (2014-08-24 05:08:19)
>> On Sunday 24 August 2014, Robert Jarzmik wrote:
>> > > By default, I'd expect Haojian to pick up the patches and send
>> > > us a pull request. He sent an Ack, but also didn't make it clear
>> > > that we should pick them up.
>> > I was thinking that they would go through the clk maintainers, hence Haojian's
>> > ack. If they should go through arm-soc, they would need Mike's ack.
>
> Robert,
>
> I'm happy to take the patches but they will need to be rebased onto
> clk-next and refactored to take into account Tomeu's api split[0].

Hi Mike,

I have had a look at clk-next and Tomeu's split.
My current understanding is that Tomeu's patches don't apply on your clk-next,
as I get conflicts.

So either I rebase my patches on top of Tomeu's tree (as this is what will drive
most of the rebase work AFAIU), or I wait for Tomeu's tree to be merged into
your clk-next. Is there any chance Tomeu's work ends up in your clk-next tree
soon ?

Cheers.

-- 
Robert
