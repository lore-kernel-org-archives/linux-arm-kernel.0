From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jan 2014 14:59:17 +0000
Subject: [PATCH] arm64/xen: redefine xen_remap on arm64
In-Reply-To: <alpine.DEB.2.02.1401031444550.8667@kaball.uk.xensource.com>
References: <1388386511-32276-1-git-send-email-baozich@gmail.com>
 <1388431259.2564.15.camel@deneb.redhat.com>
 <alpine.DEB.2.02.1401031310100.8667@kaball.uk.xensource.com>
 <20140103143104.GN7383@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1401031444550.8667@kaball.uk.xensource.com>
Message-ID: <20140103145917.GP7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 02:49:54PM +0000, Stefano Stabellini wrote:
> OK. That would be Rob's patch below.

Looks fine to me.

> Are you going to take care of sending it to Linus?

If you want to stick it in the patch system, I'll throw it in my tree.
I need to push out the next set of fixes soon anyway.

Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
