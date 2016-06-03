From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Jun 2016 11:00:40 +0100
Subject: [PATCH] arm64/efi: remove spurious WARN_ON for !4K kernels
In-Reply-To: <20160530211212.GG2984@codeblueprint.co.uk>
References: <1464189116-30898-1-git-send-email-mark.rutland@arm.com>
 <20160530211212.GG2984@codeblueprint.co.uk>
Message-ID: <20160603100040.GJ9915@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 10:12:12PM +0100, Matt Fleming wrote:
> On Wed, 25 May, at 04:11:56PM, Mark Rutland wrote:
> > 
> > No further restriction on alignment is provided in the UEFI
> > specification, neither generically nor in a rule specific to AArch64.
>  
> This surprises me. I could have sworn the intention was to add this
> restriction to the spec when the strict permissions were being
> discussed in the UEFI working groups.
> 
> Am I reinventing history?
> 
> As an aside, Mark, Jeremy, which machines did you see this warning
> triggered on? Preproduction/development boards or also in the wild?

Mark, Jeremy?

I've kept this patch marked as unread, but it's not clear to me (a) how
urgent it is (b) what tree it should go through and (c) whether it's the
right thing to do!

Will
