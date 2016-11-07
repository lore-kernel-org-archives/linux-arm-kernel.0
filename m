From: horms@verge.net.au (Simon Horman)
Date: Mon, 7 Nov 2016 09:12:29 +0100
Subject: [PATCH v2] arm64: Add support for additional relocations in the
 kexec purgatory code
In-Reply-To: <2792b205-dfdd-1362-9cf4-d886472a9357@infradead.org>
References: <1476960211-25594-1-git-send-email-catalin.marinas@arm.com>
 <2792b205-dfdd-1362-9cf4-d886472a9357@infradead.org>
Message-ID: <20161107081229.GA13099@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 09:37:03AM -0700, Geoff Levand wrote:
> On 10/20/2016 03:43 AM, Catalin Marinas wrote:
> > When compiling the kexec-tools with gcc6, the following additional
> > reolcations are generated in the purgatory.ro file:
> > 
> > R_AARCH64_ADR_PREL_PG_HI21
> > R_AARCH64_ADD_ABS_LO12_NC
> > R_AARCH64_LDST64_ABS_LO12_NC
> 
> Looks good.  Simon, please apply.
> 
> Reviewed-by: Geoff Levand <geoff@infradead.org>

Thanks, applied.
