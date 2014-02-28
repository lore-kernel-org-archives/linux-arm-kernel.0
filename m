From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Feb 2014 15:27:10 +0000
Subject: [PATCH v2 2/3] arm64: Extend the PCI I/O space to 16MB
In-Reply-To: <1393506599-11561-3-git-send-email-Liviu.Dudau@arm.com>
References: <1393506599-11561-1-git-send-email-Liviu.Dudau@arm.com>
 <1393506599-11561-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140228152710.GC13970@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 01:09:58PM +0000, Liviu Dudau wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> The patch moves the PCI I/O space (currently at 64K) before the
> earlyprintk mapping and extends it to 16MB.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

I'll push this into mainline for 3.15, no need to carry it.

-- 
Catalin
