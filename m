From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Sep 2010 10:15:40 +0100
Subject: [PATCH] ARM: Mark CPU_32v6K as depended on CPU_V7
In-Reply-To: <20100831135126.19953.11529.stgit@e102109-lin.cambridge.arm.com>
References: <20100831135126.19953.11529.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100901091540.GM8142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 02:52:32PM +0100, Catalin Marinas wrote:
> CPU_32v6K is selected by CPU_V7 but it only depends on CPU_V6.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Ok.
