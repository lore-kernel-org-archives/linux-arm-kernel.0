From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Jun 2017 15:10:53 +0100
Subject: [PATCH 13/20] arm64: ilp32: share aarch32 syscall handlers
In-Reply-To: <20170604120009.342-14-ynorov@caviumnetworks.com>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-14-ynorov@caviumnetworks.com>
Message-ID: <20170608141053.66i57zhvunrj6sei@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 04, 2017 at 03:00:02PM +0300, Yury Norov wrote:
> off_t is  passed in register pair just like in aarch32.
> In this patch corresponding aarch32 handlers are shared to
> ilp32 code.

Is the comment here relevant? IOW, do we have any AArch64/ILP32 syscall
where off_t is used as an argument? AFAICT, the *64 syscalls use loff_t
or loff_t *.

-- 
Catalin
