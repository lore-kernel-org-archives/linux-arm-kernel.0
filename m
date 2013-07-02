From: balbi@ti.com (Felipe Balbi)
Date: Wed, 3 Jul 2013 00:30:30 +0300
Subject: [PATCH v2 7/9] wlcore: sdio: add wilink clock providers
In-Reply-To: <20130702153423.GH7013@arwen.pp.htv.fi>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-8-git-send-email-coelho@ti.com>
 <20130702153423.GH7013@arwen.pp.htv.fi>
Message-ID: <20130702213030.GB10388@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 02, 2013 at 06:34:23PM +0300, Felipe Balbi wrote:
> On Tue, Jul 02, 2013 at 05:55:46PM +0300, Luciano Coelho wrote:
> > Add refclock and tcxoclock as clock providers in WiLink.  These clocks
> > are not accesible outside the WiLink module, but they are registered
> > in the clock framework anyway.  Only the WiLink chip consumes these
> > clocks.
> > 
> > In theory, the WiLink chip could be connected to external clocks
> > instead of using these internal clocks, so make the clock consumer
> > code generic enough.  If external clocks are used, then the internal
> > clock device tree nodes are not necessary, but the external ones must
> > be specified.
> > 
> > Signed-off-by: Luciano Coelho <coelho@ti.com>
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

I guess this should've been

Reviewed-by: Felipe Balbi <balbi@ti.com>

instead

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/5194aa14/attachment.sig>
