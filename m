From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Jul 2016 17:03:28 +0100
Subject: [PATCH 04/14] arm64: migrate exception table users off module.h
 and onto extable.h
In-Reply-To: <20160725034247.109173-5-paul.gortmaker@windriver.com>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
 <20160725034247.109173-5-paul.gortmaker@windriver.com>
Message-ID: <20160725160328.GC2423@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 24, 2016 at 11:42:37PM -0400, Paul Gortmaker wrote:
> These files were only including module.h for exception table
> related functions.  We've now separated that content out into its
> own file "extable.h" so now move over to that and avoid all the
> extra header content in module.h that we don't really need to compile
> these files.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
