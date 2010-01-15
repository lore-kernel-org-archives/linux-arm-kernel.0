From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jan 2010 23:14:10 +0000
Subject: [PATCH 1/5] Add "virtual kernel memory..." printout.
In-Reply-To: <1263465370-4192-2-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1263465370-4192-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1263465370-4192-2-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <20100115231410.GC28222@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2010 at 11:36:06AM +0100, Andreas Fenkart wrote:
> Code based on parisc and x86_32.

Oh, the only other thing to request is:

> +	printk(KERN_NOTICE "virtual kernel memory layout:\n"

Can the first letter of the message be capitalised please?
