From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 4 Oct 2012 16:11:57 +0200
Subject: [PATCH 0/7] Add support for Freescale's mc34708 to mc13xxx driver
In-Reply-To: <20121004135130.GC5554@sortiz-mobl>
References: <1342087073-3892-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <11987916.rOoNGcb1ly@dev1>
 <CAOMZO5AVP1L-6A7cmV-kQEfG1C+vczFKT=sQbFtLJDaGau0kRg@mail.gmail.com>
 <CAOMZO5BqZpy5Cz0BxbpdOY=sjMjhSOjfQZmJ4j7Xwe6Q7x6Yig@mail.gmail.com>
 <20121004135130.GC5554@sortiz-mobl>
Message-ID: <20121004141157.GK598@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 04, 2012 at 03:51:30PM +0200, Samuel Ortiz wrote:
> Did you send it to my samuel.ortiz at intel.com email ? I never look at it when
> going through my MFD backlog, which is why it was not applied. Which is why it
> won't be part of the 3.7 merge window, sorry about that.
I don't know why I picked that one up, but probably it's because this
address shows up in several commits:

	$ git log --grep=samuel.ortiz at intel.com | grep Samuel | sort | uniq -c
	     18     Acked-by: Samuel Ortiz <samuel.ortiz@intel.com>
	     12 Author: Samuel Ortiz <sameo@linux.intel.com>
	     27 Author: Samuel Ortiz <samuel.ortiz@intel.com>
	      4     Cc: Samuel Ortiz <samuel.ortiz@intel.com>
	      1     Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
	     50     Signed-off-by: Samuel Ortiz <samuel.ortiz@intel.com>

and one of these just happend to be the first I looked at.

hmm, *shrug*
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
