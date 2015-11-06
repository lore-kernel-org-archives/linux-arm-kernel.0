From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Nov 2015 16:05:01 +0000
Subject: [PATCH] arm64: add HAVE_LATENCYTOP_SUPPORT config
In-Reply-To: <1446825478-24824-1-git-send-email-yalin.wang2010@gmail.com>
References: <1446825478-24824-1-git-send-email-yalin.wang2010@gmail.com>
Message-ID: <20151106160501.GR6087@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 11:57:58PM +0800, yalin wang wrote:
> Add HAVE_LATENCYTOP_SUPPORT in Kconfig, so that
> we can enable this feature on ARM64

Do you know what the prerequisites for HAVE_LATENCYTOP_SUPPORT actually
are (beyond those explicitly listed as dependencies for CONFIG_LATENCYTOP)?

Will
