From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Jan 2010 17:41:01 +0000
Subject: [PATCH/RFC] arm: Enable backtrace printing on oops when PC
	iscorrupted
In-Reply-To: <1264065809-7893-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1264065809-7893-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1264527661.13482.74.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-01-21 at 09:23 +0000, Laurent Pinchart wrote:
> If PC points outside kernel text, start printing the backtrace at LR
> instead.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
