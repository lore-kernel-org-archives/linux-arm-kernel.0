From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Oct 2012 09:17:22 +0300
Subject: [PATCH v2 1/3] drivers: bus: ocp2scp: add pdata support
In-Reply-To: <20121025004806.GK11928@atomide.com>
References: <1349675983-23803-1-git-send-email-kishon@ti.com>
 <1349675983-23803-2-git-send-email-kishon@ti.com>
 <20121016165043.GS15569@atomide.com>
 <20121025004806.GK11928@atomide.com>
Message-ID: <20121025061722.GB4449@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 24, 2012 at 05:48:07PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [121016 09:53]:
> > * Kishon Vijay Abraham I <kishon@ti.com> [121007 23:01]:
> > > ocp2scp was not having pdata support which makes *musb* fail for non-dt
> > > boot in OMAP platform. The pdata will have information about the devices
> > > that is connected to ocp2scp. ocp2scp driver will now make use of this
> > > information to create the devices that is attached to ocp2scp.
> > > 
> > > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > 
> > This fixes the regression on my panda es for musb port:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Looks like nobody has picked this one up and we need it to
> fix the musb regression on omap, so I'll queue these up.

I don't seem to have the patches around in any mailbox :-(

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/aa8ffc49/attachment.sig>
