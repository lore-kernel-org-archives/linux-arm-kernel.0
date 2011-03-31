From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Thu, 31 Mar 2011 09:04:05 -0700
Subject: [PATCH 05/12] mm: alloc_contig_range() added
In-Reply-To: <1301577368-16095-6-git-send-email-m.szyprowski@samsung.com>
References: <1301577368-16095-1-git-send-email-m.szyprowski@samsung.com>
	<1301577368-16095-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1301587445.31087.1042.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-31 at 15:16 +0200, Marek Szyprowski wrote:
> +       _start = start & (~0UL << ret);
> +       _end   = alloc_contig_freed_pages(_start, end, flag); 

These names are a wee bit lacking.  Care to give them proper names that
might let a reader figure out how the "_" makes the variable different
from its nearly-identical twin?

-- Dave
