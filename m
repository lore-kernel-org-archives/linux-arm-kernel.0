From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Sep 2012 13:51:52 +0000
Subject: [PATCH v3 17/31] arm64: System calls handling
In-Reply-To: <20120910095619.GA27042@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <201209071943.37184.arnd@arndb.de> <20120910095619.GA27042@arm.com>
Message-ID: <201209101351.52902.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 September 2012, Catalin Marinas wrote:
> Yes, I've seen these but since Al's patches are not in mainline, I don't
> want to add additional dependencies to the arm64 patches (currently
> based on 3.6-rc4). Once they get into mainline, I'll add a patch that
> converts arm64 to the generic functions above.
> 
> For kernel_execve(), I think I can simplify it further and not rely on
> Al's patches (similar to other architectures doing an SVC from kernel):

Hmm, I thought one of the reasons for Al to do his series was to discourage
people from doing syscalls from kernel space, but I may be misremembering
things. Al?

	Arnd
