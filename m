From: horms@verge.net.au (Simon Horman)
Date: Mon, 7 Jan 2013 11:31:01 +0900
Subject: [PATCH 1/2] ARM: shmobile: add function declarations for sh7372
 DT helper functions
In-Reply-To: <Pine.LNX.4.64.1212311213510.24596@axis700.grange>
References: <Pine.LNX.4.64.1212311213510.24596@axis700.grange>
Message-ID: <20130107023101.GM2935@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 31, 2012 at 12:23:50PM +0100, Guennadi Liakhovetski wrote:
> sh7372_add_early_devices_dt() and sh7372_add_standard_devices_dt() are
> defined as global functions in arch/arm/mach-shmobile/setup-sh7372.c,
> but their declarations are missing. Add them to common.h, where similar
> functions for this and other SoC types are already declared.

Thanks, applied to the soc branch.
