From: JBeulich@novell.com (Jan Beulich)
Date: Mon, 19 Oct 2009 09:19:40 +0100
Subject: [PATCH] serial/atmel_serial: Fix another fallout of the
	change to BUILD_BUG_ON
In-Reply-To: <200910191638.41299.rusty@rustcorp.com.au>
References: <1255417680-25609-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20091013092644.72c78334@hskinnemoen-d830>
	<4AD44AF10200007800019801@vpn.id2.novell.com>
	<200910191638.41299.rusty@rustcorp.com.au>
Message-ID: <4ADC3D3C020000780001AA10@vpn.id2.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> Rusty Russell <rusty@rustcorp.com.au> 19.10.09 08:08 >>>
>How's this?  It's not quite valid C, but it "works":

But that's not what you proposed initially, i.e. generating a link time
error if a compile time error can't be generated (and only if even a link
time error isn't possible, a run time one should be forced).

And btw., why do you think this isn't valid C?

Jan
