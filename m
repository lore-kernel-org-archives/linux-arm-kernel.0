From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Jun 2013 14:21:17 +0100
Subject: [PATCH v2 5/5] arm64/xen: introduce CONFIG_XEN and hypercall.S
 on ARM64
In-Reply-To: <alpine.DEB.2.02.1306031745460.4589@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1306031157020.4589@kaball.uk.xensource.com>
 <1370273624-26976-5-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130603162517.GC32295@arm.com>
 <alpine.DEB.2.02.1306031745460.4589@kaball.uk.xensource.com>
Message-ID: <20130605132117.GK8758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 05:51:53PM +0100, Stefano Stabellini wrote:
> On Mon, 3 Jun 2013, Catalin Marinas wrote:
> > Otherwise, the series looks good. How do you plan to upstream this?
> 
> Good question.
> Traditionally Xen stuff goes to Linus directly via one of the Xen trees
> (Konrad's or mine), but since this is the very first Xen patch series
> for arm64 if you prefer I can submit a pull request to you instead.
> Just let me know, I am happy either way.

I can take the first series and subsequent merges can go via the Xen
tree (KVM has a similar approach).

> In any case, are you OK with sending it upstream during the next merge
> window?

Yes, if I get a pull request in time ;)

-- 
Catalin
