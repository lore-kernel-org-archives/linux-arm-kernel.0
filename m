From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jan 2011 23:24:49 +0000
Subject: [PATCH v2] ARM: Thumb-2: Fix out-of-range offset for Thumb-2
	in proc-v7.S
In-Reply-To: <1294937485-7673-1-git-send-email-dave.martin@linaro.org>
References: <1294937485-7673-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110113232449.GH24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 10:51:25AM -0600, Dave Martin wrote:
> Commit
> 
>        d30e45e (ARM: pgtable: switch order of Linux vs hardware page tables)
> 
> introduced a pre-increment addressing offset which is out of range for
> Thumb-2.  Thumb-2 only permits offsets <256.  So split the intruction in
> two for Thumb-2.

Ok, can you put it in the patch system please?  Thanks.
