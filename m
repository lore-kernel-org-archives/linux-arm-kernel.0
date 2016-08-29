From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Aug 2016 07:18:34 +0200
Subject: [PATCH] dt-bindings: touchscreen: silead_gsl1680: Document
 touchscreen-fw-name
In-Reply-To: <20160829003725.GA20749@rob-hp-laptop>
References: <1471964688-12188-1-git-send-email-hdegoede@redhat.com>
 <20160829003725.GA20749@rob-hp-laptop>
Message-ID: <20160829051834.GW3165@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Sun, Aug 28, 2016 at 07:37:25PM -0500, Rob Herring wrote:
> On Tue, Aug 23, 2016 at 05:04:48PM +0200, Hans de Goede wrote:
> > The driver has supported touchscreen-fw-name to specify the firmware to
> > load since day 0, but this was omitted from the binding, document this.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt | 1 +
> >  1 file changed, 1 insertion(+)
> 
> I'd really like to deprecate in favor of a standard property name. We've 
> somewhat agreed on 'firmware-name' though there is no common binding doc 
> yet. But given this is in use:

This has been introduced in 4.8-rc1, so it hasn't been used in any
stable version yet, and we don't have any users in tree so far.

If you want to something else, it feels like now is the time to change
it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160829/9aea5655/attachment.sig>
