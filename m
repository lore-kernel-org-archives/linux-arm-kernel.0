From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Nov 2018 17:14:37 +0000
Subject: [PATCH] arm64: hugetlb: Avoid unnecessary clearing in
 huge_ptep_set_access_flags
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A031841@G01JPEXMBKW03>
References: <20180919174437.1866-1-steve.capper@arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A031841@G01JPEXMBKW03>
Message-ID: <20181106171436.GB28592@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lei Zhang,

On Tue, Nov 06, 2018 at 01:16:01PM +0000, Zhang, Lei wrote:
> Sorry to late.
> Thanks for your patch, and I will test your patch.

Probably best to test the version that landed in mainline, as I think we
went through a few revisions of this:

http://git.kernel.org/linus/031e6e6b4e12

Thanks!

Will
