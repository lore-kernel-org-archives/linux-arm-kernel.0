From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 18 Oct 2010 16:39:22 +0200
Subject: [PATCH 0/3] Add OMAP hardware spinlock misc driver
In-Reply-To: <1287412383.29097.1603.camel@twins>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	<1287406015.29097.1579.camel@twins>
	<20101018133502.GA12449@n2100.arm.linux.org.uk>
	<1287409417.29097.1598.camel@twins>
	<AANLkTimYK_JVafj5XdN+d9O8h_qon17Jkw7LRpJVZvuO@mail.gmail.com>
	<1287412383.29097.1603.camel@twins>
Message-ID: <AANLkTi=jnPBNSMWx-fHMUoDT7W1_f-mYLQUZpi=FvaCK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 18, 2010 at 4:33 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> Without coherency everybody needs to be damn sure to flush the relevant
> bits before unlocking and such.

Yes, either that, or use non-cacheable memory.
