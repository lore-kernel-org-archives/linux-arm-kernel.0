From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Apr 2015 00:25:41 +0100
Subject: [PATCH 0/2] ARM: VDSO: minor fixes for 4.1
In-Reply-To: <1429306024-5253-1-git-send-email-nathan_lynch@mentor.com>
References: <1429306024-5253-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20150417232541.GE12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 04:27:02PM -0500, Nathan Lynch wrote:
> While investigating Arnd's v3 build issue, I became aware of a couple
> of shortcomings unrelated to runtime in the VDSO code.  With these
> applied, 'make arch/arm/vdso/' should behave better, and .gitignore is
> populated properly (I almost always build in a separate directory, so
> I hadn't noticed until now).

I think both of these are fine.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
