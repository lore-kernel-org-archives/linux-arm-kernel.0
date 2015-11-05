From: broonie@kernel.org (Mark Brown)
Date: Thu, 5 Nov 2015 15:52:08 +0000
Subject: [RFC] ASoC: Add mediatek HDMI codec driver
In-Reply-To: <1446736519.3894.113.camel@pengutronix.de>
References: <1446638053-12143-1-git-send-email-p.zabel@pengutronix.de>
 <20151104120343.GZ20228@sirena.org.uk>
 <1446736519.3894.113.camel@pengutronix.de>
Message-ID: <20151105155208.GQ18409@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 04:15:19PM +0100, Philipp Zabel wrote:
> Am Mittwoch, den 04.11.2015, 12:03 +0000 schrieb Mark Brown:
> > On Wed, Nov 04, 2015 at 12:54:13PM +0100, Philipp Zabel wrote:

> > As I keep saying I really want to see some collaboration and consensus
> > here with the goal of sharing code and achieving a consistent userspace
> > interface rather than a lot of individual independently implemented
> > drivers.

> For eld updates and jack handling I could try to go forward with
> Russell's notification prototype from the "[RFC,V2,0/5] another generic
> audio hdmi codec proposal" thread:
> https://patchwork.kernel.org/patch/7339011/

> Or are you saying there shouldn't be a Mediatek specific HDMI sound
> driver at all and this should be handled by generic code?

Well, now I take a glance at the code I'm not seeing any actual hardware
interaction here so it certainly seems like there's nothing MediaTek
specific going on.  I've not actually looked at the code beyond a brief
glance and doing a search for the helpers, like I say I'm really looking
for collaboration and consensus among the people working on HDMI here
rather than a specific solution.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151105/d4274a0c/attachment.sig>
