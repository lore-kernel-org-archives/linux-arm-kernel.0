From: rabin.vincent@stericsson.com (Rabin VINCENT)
Date: Thu, 11 Feb 2010 22:26:10 +0530
Subject: [PATCH] amba-pl011: support hardware flow control
In-Reply-To: <20100210202552.GA30854@n2100.arm.linux.org.uk>
References: <1265636510-27679-1-git-send-email-rabin.vincent@stericsson.com>
	<20100208135124.GA26608@n2100.arm.linux.org.uk>
	<20100209143055.GA6015@bnru01.bnr.st.com>
	<20100209221449.GA23083@n2100.arm.linux.org.uk>
	<20100210011637.GA8683@shareable.org>
	<20100210134515.GA2844@bnru01.bnr.st.com>
	<20100210202552.GA30854@n2100.arm.linux.org.uk>
Message-ID: <20100211165610.GA26986@bnru01.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2010 at 09:25:52PM +0100, Russell King - ARM Linux wrote:
> On Wed, Feb 10, 2010 at 07:15:21PM +0530, Rabin VINCENT wrote:
> > I've implemented this in the updated patch below.
> 
> I think this is ok.  Has it been tested?

Yes.  I was able to reproduce the described problem, and this version of
the patch fixes it.

Rabin
