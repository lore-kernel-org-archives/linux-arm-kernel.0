From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Oct 2012 09:50:43 -0700
Subject: [PATCH v2 1/3] drivers: bus: ocp2scp: add pdata support
In-Reply-To: <1349675983-23803-2-git-send-email-kishon@ti.com>
References: <1349675983-23803-1-git-send-email-kishon@ti.com>
 <1349675983-23803-2-git-send-email-kishon@ti.com>
Message-ID: <20121016165043.GS15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [121007 23:01]:
> ocp2scp was not having pdata support which makes *musb* fail for non-dt
> boot in OMAP platform. The pdata will have information about the devices
> that is connected to ocp2scp. ocp2scp driver will now make use of this
> information to create the devices that is attached to ocp2scp.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

This fixes the regression on my panda es for musb port:

Acked-by: Tony Lindgren <tony@atomide.com>
