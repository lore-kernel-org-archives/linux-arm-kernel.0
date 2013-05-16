From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 May 2013 16:01:56 +0100
Subject: [RFC PATCH v2 11/11] ARM64: mm: THP support.
In-Reply-To: <1368006763-30774-12-git-send-email-steve.capper@linaro.org>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-12-git-send-email-steve.capper@linaro.org>
Message-ID: <20130516150155.GG18308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 10:52:43AM +0100, Steve Capper wrote:
> Bring Transparent HugePage support to ARM. The size of a
> transparent huge page depends on the normal page size. A
> transparent huge page is always represented as a pmd.
> 
> If PAGE_SIZE is 4KB, THPs are 2MB.
> If PAGE_SIZE is 64KB, THPs are 512MB.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
