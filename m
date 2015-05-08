From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 8 May 2015 09:19:45 +0200
Subject: [PATCH 4/6] dmaengine: sun6i: Add support for Allwinner H3
 (sun8i) variant
In-Reply-To: <20150508034426.GX3521@localhost>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-5-git-send-email-jenskuske@gmail.com>
 <20150506101342.GC11057@lukather> <20150508034426.GX3521@localhost>
Message-ID: <20150508071945.GN11057@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Fri, May 08, 2015 at 09:14:26AM +0530, Vinod Koul wrote:
> On Wed, May 06, 2015 at 12:13:42PM +0200, Maxime Ripard wrote:
> > On Wed, May 06, 2015 at 11:31:31AM +0200, Jens Kuske wrote:
> > > The H3 SoC has the same dma engine as the A31 (sun6i), with a
> > > reduced amount of endpoints and physical channels. Add the proper
> > > config data and compatible string to support it.
> > > 
> > > Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> 
> This looks fine to me, I think can be merged now. Do you guys want the
> mainatainers to pick up patches to their subsystem or merge them tgether,
> though don't see any dependency though

It can be merged through your tree, like you said there's no
particular dependencies on our side.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150508/93fe6653/attachment-0001.sig>
