From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 29 Sep 2011 10:21:49 +0100
Subject: [PATCH 0/2] GIC OF bindings
In-Reply-To: <1317268436-1613-1-git-send-email-robherring2@gmail.com>
References: <1317268436-1613-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110929092149.GL17204@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 10:53:54PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> With recent patches for VIC device tree support and GIC MULTI_IRQ support,
> it is evident that the irq domain support should be moved into the core GIC
> code and not be dependent on the DT initialization. So I've split things up
> into 2 patches separating irq_domain and device-tree code.
> 
> This should only change the internals of the GIC code. The binding is
> unchanged from the previous version. Yeah!
> 
> The full series is available here. This includes Russell's devel-stable and
> for-next branches and Nico's vmalloc branch.

Looks good to me!

Reviewed-by: Jamie Iles <jamie@jamieiles.com>
