From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Nov 2012 09:47:39 +0000
Subject: [PATCH 284/493] arm64: remove use of __devinit
In-Reply-To: <1353349642-3677-284-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-284-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121120094738.GA6539@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 06:23:53PM +0000, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Catalin Marinas <catalin.marinas@arm.com> 
> Cc: linux-arm-kernel at lists.infradead.org 

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
