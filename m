From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 19 May 2011 15:55:10 +0200
Subject: [PATCH] MAX1111: Fix race condition causing NULL pointer exception
In-Reply-To: <201105191451.40416.morpheus.ibis@gmail.com>
References: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
	<20110519123507.GA4950@elf.ucw.cz>
	<201105191451.40416.morpheus.ibis@gmail.com>
Message-ID: <201105191555.10301.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 19, 2011 02:51:40 PM Pavel Herrmann wrote:
> Hi
> 
> On Thursday, May 19, 2011 02:35:08 PM Pavel Machek wrote:
> > > you're potentially doing with this:
> > In some other mail, you said "just add the locking". Pavel H.
> > actually produced patch doing so...
> 
> yes, that was the original version of the patch. while I agree with Marek
> on locks not being the right way, I was going send a cleaner version of
> the original locking patch today (locking in probe is not really
> necessary), you just beat me to it.

Please send the patch inline next time ;-)

> 
> Pavel Herrmann
