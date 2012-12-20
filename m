From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 20 Dec 2012 13:12:28 +0000
Subject: [Xen-devel] [PATCH v2 5/6] ARM: Dummy Virtual Machine platform
 support
In-Reply-To: <50D1DC6F.3010304@codeaurora.org>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
 <1355762141-29616-6-git-send-email-will.deacon@arm.com>
 <alpine.DEB.2.02.1212181202310.17523@kaball.uk.xensource.com>
 <20121218131401.GB22139@mudshark.cambridge.arm.com>
 <50D0AF5C.1070605@codeaurora.org>
 <50D0B384.40605@arm.com> <50D1DC6F.3010304@codeaurora.org>
Message-ID: <alpine.DEB.2.02.1212201310080.17523@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Dec 2012, Christopher Covington wrote:
> > What would be the point of using DCC?
> 
> It seemed like ARM-Ltd.-architected peripherals were picked for the timer and
> interrupt controller, so I wondered why not for the console as well. As best
> I'm aware, unless one ventures into the PrimeCell line with the PL011, DCC is
> the closest match for an officially architected console mechanism.

I certainly wouldn't want to mandate the presence of any devices that
require emulation in the DT for a virtual machine, including DCC, as
simple as it might be.
