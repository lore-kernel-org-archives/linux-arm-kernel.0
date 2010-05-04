From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 May 2010 18:19:32 +0100
Subject: [PATCH 6/8] ARM: Implement copy_to_user_page() for noMMU
In-Reply-To: <20100504164448.26355.54748.stgit@e102109-lin.cambridge.arm.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164448.26355.54748.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100504171932.GH30601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 05:44:48PM +0100, Catalin Marinas wrote:
> Commit 7959722 introduced calls to copy_(to|from)_user_page() from
> access_process_vm() in mm/nommu.c. The copy_to_user_page() was not
> implemented on noMMU ARM.

Ok.
