From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 18:39:42 +0000
Subject: [PATCH] bitops: remove condition code clobber for CLZ
In-Reply-To: <1294767725-14814-1-git-send-email-rabin@rab.in>
References: <1294767725-14814-1-git-send-email-rabin@rab.in>
Message-ID: <20110111183942.GL11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 11:12:05PM +0530, Rabin Vincent wrote:
> The CLZ instruction does not alter the condition flags, so remove the
> "cc" clobber from the inline asm for fls().

Do you have any evidence that this changes anything, or is it just
subjective?
