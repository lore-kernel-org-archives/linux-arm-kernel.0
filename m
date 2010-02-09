From: rabin.vincent@stericsson.com (Rabin VINCENT)
Date: Tue, 9 Feb 2010 20:00:56 +0530
Subject: [PATCH] amba-pl011: support hardware flow control
In-Reply-To: <20100208135124.GA26608@n2100.arm.linux.org.uk>
References: <1265636510-27679-1-git-send-email-rabin.vincent@stericsson.com>
	<20100208135124.GA26608@n2100.arm.linux.org.uk>
Message-ID: <20100209143055.GA6015@bnru01.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2010 at 02:51:24PM +0100, Russell King - ARM Linux wrote:
> On Mon, Feb 08, 2010 at 07:11:50PM +0530, Rabin Vincent wrote:
> > Enable/disable hardware flow control as requested by the termios.
> 
> From what I remember, I didn't implement this because there were
> corner cases to be dealt with.  I don't remember what they were
> off hand though.

We haven't seen any problems with it thus far.  Nothing obvious strikes
me on rechecking the pl011 spec; it would be helpful if you could
elaborate.

Either way, this patch should be safe to apply since existing users of
the driver shouldn't be affected.

Rabin
