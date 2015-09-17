From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Sep 2015 08:46:58 +0200
Subject: [PATCH 5/6] dmaengine: sun6i: Fix module autoload for OF
 platform driver
In-Reply-To: <20150916205931.GA5882@goodgumbo.baconseed.org>
References: <20150916205931.GA5882@goodgumbo.baconseed.org>
Message-ID: <20150917064658.GZ4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 10:59:31PM +0200, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150917/e638e725/attachment.sig>
