From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Oct 2013 15:07:12 +0100
Subject: [PATCH v8 16/19] arm,arm64: do not always merge biovec if we
 are running on Xen
In-Reply-To: <alpine.DEB.2.02.1310181322301.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
 <1382031814-8782-16-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1310181322301.26077@kaball.uk.xensource.com>
Message-ID: <20131018140711.GO23462@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 01:23:59PM +0100, Stefano Stabellini wrote:
> are you OK with this patch?
> 
> It shouldn't have any impact when running on native, only on Xen.

I don't have an opinion on what it does but since it only affects Xen,
it's fine by me.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
