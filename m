From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Aug 2013 13:55:08 +0100
Subject: [PATCH] ARM: fix typo in is_gate_vma() macro
In-Reply-To: <1375824875-1934-1-git-send-email-minipli@googlemail.com>
References: <1375824875-1934-1-git-send-email-minipli@googlemail.com>
Message-ID: <20130807125508.GG23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 11:34:35PM +0200, Mathias Krause wrote:
> Commit a5463cd3 "ARM: make vectors page inaccessible from userspace"
> introduced a typo making arch_vma_name() always return "[vectors]".
> Fix up that regression (of the hush-hush security fix).

And if you search the list archives, you will see that I've already
replied to patches exactly like this many times so far.  Thanks.
