From: bp@alien8.de (Borislav Petkov)
Date: Fri, 18 May 2018 13:11:32 +0200
Subject: [PATCH] ghes_edac: enable HIP08 platform edac driver
In-Reply-To: <8602b133-e0fa-57e2-5159-9d34a1ded85f@arm.com>
References: <1526039543-180996-1-git-send-email-zhengqiang10@huawei.com>
 <20180511121901.GA12705@pd.tnic> <5AF90C70.408@huawei.com>
 <20180514094709.GC23049@pd.tnic>
 <cb24735c-d251-4dd2-a02f-91e476776824@arm.com>
 <20180514164720.GH23049@pd.tnic>
 <da776696-ddbf-c35e-1dd4-b6e0ce91aed6@arm.com>
 <20180516182958.GB17092@pd.tnic>
 <8602b133-e0fa-57e2-5159-9d34a1ded85f@arm.com>
Message-ID: <20180518111132.GC17285@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 07:02:18PM +0100, James Morse wrote:
> v4.17-rc5 has 'return 0' here. Wouldn't this change means no ghes can be
> registered unless ghes_edac is also supported by the platform?
> Shouldn't this be '0' for a silent failure?

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?h=for-next&id=cc7f3f132658289b6661ab8294ab08a9d32ea026

> Tested on Seattle and some cranky homebrew-no-DMI firmware:
> Tested-by: James Morse <james.morse@arm.com>
> 
> With the ENODEV/0 thing above:
> Reviewed-by: James Morse <james.morse@arm.com>

Thanks, adding.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
