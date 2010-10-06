From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 06 Oct 2010 12:45:40 -0700
Subject: [PATCHv2 1/7] pwm: Add pwm core driver
In-Reply-To: <F45880696056844FA6A73F415B568C6953571D4F05@EXDCVYMBSTM006.EQ1STM.local>
	(Arun MURTHY's message of "Wed, 6 Oct 2010 06:03:28 +0200")
References: <1286280002-1636-1-git-send-email-arun.murthy@stericsson.com>
	<1286280002-1636-2-git-send-email-arun.murthy@stericsson.com>
	<20101005122225.6dda30ff.akpm@linux-foundation.org>
	<F45880696056844FA6A73F415B568C6953571D4F05@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <87ocb7jeaj.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arun MURTHY <arun.murthy@stericsson.com> writes:

[...]

>> 
>> I suggest that you work on Kevin's comments before making any code
>> changes though.
>
> This pwm driver also supports the Davinci pwm driver as suggested by
> Kelvin.

My concern isn't whether it supports davinci or not.  Adapting existing
drivers is the easy part.

My concern is that there are now two proposals for a generic PWM
framework, and I would prefer to see that those projects are aligned
before anything merges.

Kevin
