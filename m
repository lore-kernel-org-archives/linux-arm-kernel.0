From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 6 Apr 2011 22:42:47 +0200
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <BANLkTin-u=U_-cUH9oCco0LjEBuQmh4wag@mail.gmail.com>
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop>
	<BANLkTinubrmryu=Bco5_AVcj_arn7SWZxw@mail.gmail.com>
	<op.vti9ote53ri7v4@arend-laptop>
	<BANLkTin-u=U_-cUH9oCco0LjEBuQmh4wag@mail.gmail.com>
Message-ID: <BANLkTi=x89+52cMeutOB7J--QQta+mX_wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/6 Rafa? Mi?ecki <zajec5@gmail.com>:
> If we want to have two drivers working on two (different) cores
> simultaneously, we will have to add trivial mutex to group core
> switching with core operation (read/write).

With a little of work we could avoid switching and mutexes on no-host
boards. MMIO is not limited to one core at once in such a case.

-- 
Rafa?
