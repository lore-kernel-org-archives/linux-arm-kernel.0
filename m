From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 12 Jul 2017 15:41:51 +0200
Subject: [PATCH v3 00/12] AC97 device/driver model revamp
In-Reply-To: <20170712105530.p3yb2gj3vt3thlab@sirena.org.uk> (Mark Brown's
 message of "Wed, 12 Jul 2017 11:55:30 +0100")
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
 <20170712105530.p3yb2gj3vt3thlab@sirena.org.uk>
Message-ID: <87r2xlsrfk.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Fri, Jun 30, 2017 at 09:43:56PM +0200, Robert Jarzmik wrote:
>> Hi Lars, Mark, Charles, Lee,
>> 
>> This is a resend of the v2, with patch 1 added (forgotten in v2). Patch 12 was
>> slightly modified after module unloading tests, and Dmitry acks were added.
>
> This all looks good to me modulo the naming thing Takashi raised.
Ok Mark, let us do this :
 - I'll do some extensive testing this week just to ensure the v4 is on par with
 v3 (should be the case but I prefer to be carefull).
 - Once I'm sure it's not worse than before, I'll post a v4.

That might give a couple of days to :
 - have Lee's ack on patch 6/12

   Lee, could you have a look please, that touches your tree, and if you have
   concerns I'd rather wait before releasing v4 in order to take them into
   account ?

 - give Lars another opportunity to complain about what I had forgotten :)
 - give me time to retest

Cheers.

-- 
Robert
