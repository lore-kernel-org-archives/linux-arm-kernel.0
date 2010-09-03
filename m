From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Sep 2010 08:31:35 +0100
Subject: [PATCH 14/24] msm: add hotplug stub functions
In-Reply-To: <1283467000.3674.381.camel@c-dwalke-linux.qualcomm.com>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
	<1282712273-344-15-git-send-email-johlstei@codeaurora.org>
	<20100902111157.GX26319@n2100.arm.linux.org.uk>
	<1283446177.3674.0.camel@c-dwalke-linux.qualcomm.com>
	<20100902171253.GX26319@n2100.arm.linux.org.uk>
	<1283467000.3674.381.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100903073135.GD26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 03:36:40PM -0700, Daniel Walker wrote:
> If no others use it .. We can do this to fix them all. What do you
> think?

If no one else implements it, then you can't suspend, nor can you
support kexec.  (We should update Kconfig to add this as a dependency.)

So if you want these features, you'll need to implement hotplug CPU
support.
