From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Wed, 16 Sep 2009 00:47:34 +0200
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <1253053609.3273.139.camel@linux-1lbu> (Steve Chen's message of
	"Tue, 15 Sep 2009 17:26:49 -0500")
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<20090915103739.GA19519@elf.ucw.cz>
	<1253017761.3273.117.camel@linux-1lbu>
	<200909151541.08852.marek.vasut@gmail.com>
	<1253032210.3273.128.camel@linux-1lbu>
	<94a0d4530909151158y489a96e3x63ff932c713822b0@mail.gmail.com>
	<1253043875.3273.131.camel@linux-1lbu>
	<m3k4zzdimy.fsf@intrepid.localdomain>
	<1253053609.3273.139.camel@linux-1lbu>
Message-ID: <m33a6nddvd.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Steve Chen <schen@mvista.com> writes:

> If I know for sure that these are the processors that need that block of
> code, your suggestion makes perfect sense.  Unfortunately, I don't know.

Then I wouldn't write "Accurate delays". "Different", maybe.
"Accurate", we don't know.

> My primary goals are
>
> 1.  Put a stop to this thread (so far I have failed miserably)
> 2.  Document that block of code.
> 3.  If it makes someone's life easier.. it would be a bonus.

Uncertain comments don't make life easier. Just write what's certain,
or nothing if nothing is.
-- 
Krzysztof Halasa
