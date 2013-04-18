From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 15:19:52 +0100
Subject: [PATCH 1/3] ARM: also support TWD clock, instantiated from
 platform data
In-Reply-To: <1365005636-17526-2-git-send-email-g.liakhovetski@gmx.de>
References: <1365005636-17526-1-git-send-email-g.liakhovetski@gmx.de>
 <1365005636-17526-2-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <20130418141952.GU14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 06:13:54PM +0200, Guennadi Liakhovetski wrote:
> While gradually switching clock initialisation to DT some architectures
> can have TWD device in DT, but supplying clock initialised from platform
> data. This patch adds support for such configurations to ARM.

Why can't you fix the clock problem at the same time - or sort out the
clock problem first and then add a DT description for TWD?
