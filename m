From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Dec 2010 10:13:03 +0000
Subject: [PATCH] mmci: partially revert clock divisor code
In-Reply-To: <1291884775-25509-1-git-send-email-linus.walleij@stericsson.com>
References: <1291884775-25509-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101210101303.GA19552@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 09:52:55AM +0100, Linus Walleij wrote:
> I misread the datasheet as if bypass mode was not available at all
> on the ux500's, I was wrong. It is there, the datasheet just
> states that you should not have to use it.

Should this be merged with the patch which introduced this change?
