From: p.pisati@gmail.com (Paolo Pisati)
Date: Tue, 9 Oct 2018 11:24:32 +0200
Subject: 4.19-rcX: WARN_ON() arch/arm64/kernel/setup.c:271
 reserve_memblock_reserved_regions
In-Reply-To: <47fa0375-ed69-0cbc-9dcb-0cafb9184f24@arm.com>
References: <20181008151138.GA19635@harukaze>
 <47fa0375-ed69-0cbc-9dcb-0cafb9184f24@arm.com>
Message-ID: <20181009092432.GA10312@harukaze>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 05:03:27PM +0100, James Morse wrote:

> But! DT's that have this reserved-but-not-memory are already out there, so we
> should work around this in the kernel.

Ack, thanks for the explanation.
-- 
bye,
p.
