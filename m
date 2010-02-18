From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Feb 2010 17:07:50 +0000
Subject: [PATCH/RFC] arm: Enable backtrace printing on oops when PC
	iscorrupted
In-Reply-To: <1264527661.13482.74.camel@pc1117.cambridge.arm.com>
References: <1264065809-7893-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1264527661.13482.74.camel@pc1117.cambridge.arm.com>
Message-ID: <20100218170750.GF20243@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2010 at 05:41:01PM +0000, Catalin Marinas wrote:
> On Thu, 2010-01-21 at 09:23 +0000, Laurent Pinchart wrote:
> > If PC points outside kernel text, start printing the backtrace at LR
> > instead.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Has this been queued by someone?  If not, please send it to the patch
system.
