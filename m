From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 23 Nov 2012 12:06:54 +0000
Subject: [PATCH 9/9] ARM: remove mach .handle_irq for VIC users
In-Reply-To: <1353466713-18967-10-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-10-git-send-email-robherring2@gmail.com>
Message-ID: <20121123120654.GC1941@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 08:58:33PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that the VIC initialization sets up the handle_arch_irq pointer, we
> can remove it for all machines and make it static.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Jamie Iles <jamie@jamieiles.com>
