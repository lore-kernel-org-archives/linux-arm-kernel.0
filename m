From: maz@misterjones.org (Marc Zyngier)
Date: Wed, 03 Mar 2010 12:03:22 +0100
Subject: Current status of interrupt handling capability of pca953x gpio
	driver.
In-Reply-To: <20100302160401.bc8b73df.akpm@linux-foundation.org>
References: <eedb5541003010818r3a917a42rc973a4a74076a27@mail.gmail.com>
	<3131fcab4adc999286a99435352e1deb.squirrel@www.loen.fr>
	<20100302160401.bc8b73df.akpm@linux-foundation.org>
Message-ID: <38ed79ea75e3396a0d5e48cfe75dd5d4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 2 Mar 2010 16:04:01 -0800, Andrew Morton
<akpm@linux-foundation.org> wrote:

> I was planning on merging
> 
> gpio-pca953xc-add-interrupt-handling-capability.patch
> gpio-pca953xc-add-interrupt-handling-capability-fix.patch
> gpio-pca953xc-add-interrupt-handling-capability-v4.patch
> 
> into 2.6.34 unless someone stops me.

Looks great! Thanks a lot Andrew.

Now if I could have some comments on this [1] related patch?
It would make life a lot easier for driver developers.

Thanks,

        M.

[1] http://lwn.net/Articles/375463/
-- 
Who you jivin' with that Cosmik Debris?
