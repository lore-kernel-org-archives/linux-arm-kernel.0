From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jun 2018 11:33:32 +0100
Subject: [PATCH v12 0/5] Fix issues with huge mapping in ioremap for ARM64
In-Reply-To: <1a648674-da56-6664-bf3c-0cdf825ad1e3@codeaurora.org>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
 <1a648674-da56-6664-bf3c-0cdf825ad1e3@codeaurora.org>
Message-ID: <20180604103332.GF9482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chintan,

On Mon, Jun 04, 2018 at 11:26:28AM +0530, Chintan Pandya wrote:
> Just curious to know, is there anything that I should be addressing
> in these patches ? For now, I don't see anything from my side that
> requires modification, unless one has some more review comments on
> this.
> 
> Status so far on and around this:
>  - Status of Toshi's series of patches is still not clear to me.
>    However, if this series can get through first, there won't
>    be conflicting scenarios as far as arm64 is concerned.
>  - I've rebased these patches on tip
>  - Also re-tested these patches for long duration tests with
>    1 GB mapping case also exercised enough. Test ended positively.

I'll try to review this version today.

Will
