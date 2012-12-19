From: alekskartashov@parallels.com (Alexander Kartashov)
Date: Wed, 19 Dec 2012 20:44:27 +0400
Subject: Enable the syscall kcmp in ARM Linux port
In-Reply-To: <20689.54803.684081.31731@pilspetsen.it.uu.se>
References: <20689.54803.684081.31731@pilspetsen.it.uu.se>
Message-ID: <1355935470-21001-1-git-send-email-alekskartashov@parallels.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear colleagues,

I'm developing an ARM port of the CRIU suite
so I need the syscall kcmp that is currently
available only in the x86 port of the kernel.

This patchset enables the syscall kcmp 
in the ARM port of the Linux kernel.

--
Sincerely yours,
Alexander Kartashov
