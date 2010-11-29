From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 29 Nov 2010 15:59:21 +0800
Subject: [PATCH 1/3] Add a common struct clk
In-Reply-To: <AANLkTimuw=FfHn7KtbkNSgwqAkS-6CKA4Rx=-dac-dhg@mail.gmail.com>
References: <1284522014.516876.675872472687.0.gpush@pororo>
	<1284522014.517347.33297989274.1.gpush@pororo>
	<AANLkTimuw=FfHn7KtbkNSgwqAkS-6CKA4Rx=-dac-dhg@mail.gmail.com>
Message-ID: <201011291559.21928.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

>   Are you planning to revise the patch-set or just taking time to
> resubmit as such?

I've reworked this patch to allow clocks that are enabled/disabled in atomic 
contexts, it's here if you'd like a preview:

http://kernel.ubuntu.com/git?p=jk/dt/linux-2.6.git;a=commitdiff;h=33220e119d3213282d4234fec7438baa6d04b5f0

I'm just waiting on some initial feedback, will post to l-a-k once that's in.

Regards,


Jeremy
