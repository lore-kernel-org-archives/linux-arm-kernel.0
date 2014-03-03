From: steve.capper@linaro.org (Steve Capper)
Date: Mon, 3 Mar 2014 08:01:14 +0000
Subject: [PATCH 1/5] mm: hugetlb: Introduce huge_pte_{page,present,young}
In-Reply-To: <1392737235-27286-2-git-send-email-steve.capper@linaro.org>
References: <1392737235-27286-1-git-send-email-steve.capper@linaro.org>
 <1392737235-27286-2-git-send-email-steve.capper@linaro.org>
Message-ID: <20140303080113.GA14340@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 03:27:11PM +0000, Steve Capper wrote:
> Introduce huge pte versions of pte_page, pte_present and pte_young.
> This allows ARM (without LPAE) to use alternative pte processing logic
> for huge ptes.
> 
> Where these functions are not defined by architectural code they
> fallback to the standard functions.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Hi,
I was wondering if this patch looks reasonable to people?

Thanks,
-- 
Steve
