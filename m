From: linus.walleij@stericsson.com (Linus WALLEIJ)
Date: Fri, 10 Dec 2010 11:41:32 +0100
Subject: [PATCH] mmci: partially revert clock divisor code
In-Reply-To: <20101210101303.GA19552@n2100.arm.linux.org.uk>
References: <1291884775-25509-1-git-send-email-linus.walleij@stericsson.com>
	<20101210101303.GA19552@n2100.arm.linux.org.uk>
Message-ID: <CEE6BB42CAD6E947908279175AF8470A075EE07BDD@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Russell]
> On Thu, Dec 09, 2010 at 09:52:55AM +0100, Linus Walleij wrote:
> > I misread the datasheet as if bypass mode was not available at all
> > on the ux500's, I was wrong. It is there, the datasheet just
> > states that you should not have to use it.
> 
> Should this be merged with the patch which introduced this change?

If you want to squash them into one, feel free to go ahead. I'm fine
either way.

Yours,
Linus Walleij
