From: morpheus.ibis@gmail.com (Pavel Herrmann)
Date: Thu, 19 May 2011 14:51:40 +0200
Subject: [PATCH] MAX1111: Fix race condition causing NULL pointer exception
In-Reply-To: <20110519123507.GA4950@elf.ucw.cz>
References: <1305731918-20164-1-git-send-email-morpheus.ibis@gmail.com>
	<20110518152935.GJ5913@n2100.arm.linux.org.uk>
	<20110519123507.GA4950@elf.ucw.cz>
Message-ID: <201105191451.40416.morpheus.ibis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thursday, May 19, 2011 02:35:08 PM Pavel Machek wrote:
> > you're potentially doing with this:
> In some other mail, you said "just add the locking". Pavel H.
> actually produced patch doing so...

yes, that was the original version of the patch. while I agree with Marek on 
locks not being the right way, I was going send a cleaner version of the 
original locking patch today (locking in probe is not really necessary), you 
just beat me to it.

Pavel Herrmann
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Fix-NULL-pointer-exception-in-max1111.patch
Type: text/x-patch
Size: 2110 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110519/db197747/attachment.bin>
