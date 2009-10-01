From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Oct 2009 16:30:22 +0100
Subject: [PATCH] ARM: allow empty ATAG_CORE
In-Reply-To: <1254351180-29199-1-git-send-email-davidb@codeaurora.org>
References: <1254347072-27932-1-git-send-email-davidb@codeaurora.org>
	<1254351180-29199-1-git-send-email-davidb@codeaurora.org>
Message-ID: <20091001153022.GA30326@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2009 at 03:53:00PM -0700, David Brown wrote:
> From: David Brown <davidb@quicinc.com>
> 
> The ATAG_CORE is allowed to be empty.  Although this is handled
> by parse_tag_core(), __vet_atags during startup rejects this tag
> unless it contains data.  Allow the initial tag to be either the
> full size, or empty.

Please send to the patch system, thanks.
