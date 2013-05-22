From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 May 2013 01:14:57 +0100
Subject: [PATCH] ARM: at91: Fix: Change internal SRAM memory type to
 "MT_MEMORY_SO"
In-Reply-To: <1369011979-21354-1-git-send-email-wenyou.yang@atmel.com>
References: <1369011911-21282-1-git-send-email-wenyou.yang@atmel.com>
 <1369011979-21354-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130522001457.GA18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 09:06:19AM +0800, Wenyou Yang wrote:
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

This needs more of a description.  Also, for a single patch, it's silly
to send two mails, the first being a cover which has a little more
information in it about the patch than the patch itself.

You need to explain _why_ you're making this change.  What I want to see
is that you've thought about the implications of this - particularly that
you know that strongly ordered memory does *not* imply any ordering with
any other memory types.

In other words, I want to know that this change is not a bodge but there's
a real reason behind it.
