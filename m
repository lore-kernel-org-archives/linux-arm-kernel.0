From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jan 2015 11:08:34 +0000
Subject: [PATCH 0/4] ARM64 compilation fixes for missing header includes
In-Reply-To: <20150106014554.27249.89116.stgit@dusk.lan>
References: <20150106014554.27249.89116.stgit@dusk.lan>
Message-ID: <20150107110834.GG7485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 01:51:56AM +0000, Paul Walmsley wrote:
> Hi Will & Catalin,
> 
> An ARM64 build here on next-20150105 breaks due to some missing
> header file includes.  Looks like someone reorganized some
> headers - although I have not tracked down what the root cause
> is.  These patches get the kernel building again.  They are based
> on the arm64 fixes/core branch.

Thanks Paul. Whilst the breakage appears in -next, I'll queue these for 3.19
as they are straight-forward fixes.

Will
