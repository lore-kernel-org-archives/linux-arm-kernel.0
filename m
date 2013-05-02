From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 19:37:56 +0200
Subject: [PATCH] ARM: iop13xx: change type of ioremap function
In-Reply-To: <1367515260-32364-1-git-send-email-lauraa@codeaurora.org>
References: <1367515260-32364-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <201305021937.56853.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Laura Abbott wrote:
> Commit cd024d4245b2bfbd824b911f11a9756d1d6c167d
> (ARM: 7704/1: mm: Use phys_addr_t properly for ioremap functions)
> changed the type of the ioremap functions to actually use phys_addr_t
> instead of unsigned long. Change the type of the arch_ioremap function
> to use phys_addr_t as well.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Hi Laura,

I've just sent a patch fixing up the same bug and all others
that go along with it.

	Arnd
