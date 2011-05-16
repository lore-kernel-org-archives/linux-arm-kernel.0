From: mingo@elte.hu (Ingo Molnar)
Date: Mon, 16 May 2011 14:03:02 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	callfiltering
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD37@saturn3.aculab.com>
References: <1305299880.2076.31.camel@localhost.localdomain>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AD37@saturn3.aculab.com>
Message-ID: <20110516120302.GB7128@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* David Laight <David.Laight@ACULAB.COM> wrote:

> [...] unfortunately it worked by looking at the user-space buffers on system 
> call entry - and a multithreaded program can easily arrange to update them 
> after the initial check! [...]

Such problems of reliability/persistency of security checks is exactly one of 
my arguments why this should not be limited to the syscall boundary, if you 
read the example i have provided in this discussion.

Thanks,

	Ingo
