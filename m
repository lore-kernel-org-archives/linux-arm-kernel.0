From: khilman@ti.com (Kevin Hilman)
Date: Wed, 09 Mar 2011 08:28:45 -0800
Subject: [PATCH] OMAP4: clockdomain: Follow recommended enable sequence
In-Reply-To: <4D775418.6050105@ti.com> (Rajendra Nayak's message of "Wed, 09
	Mar 2011 15:49:04 +0530")
References: <1299245123-23444-1-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1103081937100.15132@utopia.booyaka.com>
	<4D775418.6050105@ti.com>
Message-ID: <87zkp4dzr6.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

>> In terms of triage, does this patch fix something that currently doesn't
>> work (meaning that we should try to merge it for 2.6.39)?  Or can we plan
>> to merge this during the 2.6.40 time frame?  It would be ideal, of course,
>> if we could wait until 2.6.40, given how close we are to the merge window
>> opening.
>
> Since no clockdomains on OMAP4 were programmed in HW_AUTO untill now,
> we did not have any issues, but with the recent series from Santosh
> (which adds mpu ret/off support in idle/suspend) programming the
> clockdomains to HW_AUTO did show issues/aborts, and this patch
> fixes them.

FWIW, I was planning to merge the OMAP4 MPU ret/off series from Santosh
for 2.6.39, so this patch would be required for that to series to work.

Kevin
