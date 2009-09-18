From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 18 Sep 2009 09:53:55 +0200
Subject: [arm-gnu] Problems with pthread on ARM/PXA270
In-Reply-To: <1253141684.6443.27.camel@Ubuntu-Desktop>
References: <200909160926.02036.schindele@nentec.de>
	<1253141684.6443.27.camel@Ubuntu-Desktop>
Message-ID: <20090918075355.GA13044@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2009 at 08:54:44AM +1000, James wrote:
> Are you running with superuser privileges?  My manpage tells me that
> SCHED_RR is only available if run with superuser privileges.
Note that pthread_attr_setschedpolicy has a return value that tells you
if the function was successful.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
