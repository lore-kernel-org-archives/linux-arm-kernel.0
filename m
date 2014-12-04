From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 04 Dec 2014 22:20:55 +0100
Subject: [PATCH 1/3] ARM: pxa: add regulator_has_full_constraints to corgi
 board file
In-Reply-To: <20141204204939.GY7712@sirena.org.uk> (Mark Brown's message of
 "Thu, 4 Dec 2014 20:49:39 +0000")
References: <1417691402-28166-1-git-send-email-dbaryshkov@gmail.com>
 <87iohrywom.fsf@free.fr> <20141204204939.GY7712@sirena.org.uk>
Message-ID: <874mtbyuvc.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Thu, Dec 04, 2014 at 09:41:45PM +0100, Robert Jarzmik wrote:
>> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
>
>> > +	regulator_has_full_constraints();
>
>> Added Mark for review, as I was thinking regulator_has_full_constraints() was to
>> be used to disable unused regulators, a bit like in the clock framework, rather
>> than provide a way to provide automatically dummy regulators.
>
>> If Mark acks, I'll take the serie.
>
> It's both, it's telling the core that the board has told it about all
> the regulator mappings it's ever going to tell it about.
OK, I'll take that as an Acked-by then.

Cheers.

-- 
Robert
