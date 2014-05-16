From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 May 2014 17:49:18 +0100
Subject: [PATCH 2/2] ARM: Kconfig: remove dependence of
 CONFIG_DEBUG_RODATA on !kexec
In-Reply-To: <1399887117-2605-2-git-send-email-Nikolay.Borisov@arm.com>
References: <1399887117-2605-1-git-send-email-Nikolay.Borisov@arm.com>
 <1399887117-2605-2-git-send-email-Nikolay.Borisov@arm.com>
Message-ID: <20140516164917.GE1694@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 10:31:57AM +0100, Nikolay Borisov wrote:
> Remove DEBUG_RODATA dependence on !kexec since "ARM: kexec: Make .text R/W in
> machine_kexec" fixes the incompatibility between those 2
> options.
> 
> Signed-off-by: Nikolay Borisov <Nikolay.Borisov@arm.com>

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
