From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Nov 2014 16:07:38 +0000
Subject: [PATCHv3] arm64: add support to dump the kernel page tables
In-Reply-To: <20141126112941.GA11184@linaro.org>
References: <1416961719-6644-1-git-send-email-lauraa@codeaurora.org>
 <20141126112941.GA11184@linaro.org>
Message-ID: <20141126160738.GK14866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 11:29:42AM +0000, Steve Capper wrote:
> On Tue, Nov 25, 2014 at 04:28:39PM -0800, Laura Abbott wrote:
> > In a similar manner to arm, it's useful to be able to dump the page
> > tables to verify permissions and memory types. Add a debugfs file
> > to check the page tables.
> >
> 
> Hi Laura,
> Just one comment below to address, then:
> Acked-by: Steve Capper <steve.capper@linaro.org>
> Tested-by: Steve Capper <steve.capper@linaro.org>

Applied with missing #include and your tags.

Thanks,

Will
