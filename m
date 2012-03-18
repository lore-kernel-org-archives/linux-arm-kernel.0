From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 18 Mar 2012 10:22:41 +0100
Subject: [PATCH] of: Add generic device tree DMA helpers
In-Reply-To: <20120317104751.4F00E3E0910@localhost>
References: <4F22DEF2.5000807@ti.com>
 <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <201203150922.06379.arnd@arndb.de>
 <20120315102736.GA25371@avionic-0098.adnet.avionic-design.de>
 <20120317104751.4F00E3E0910@localhost>
Message-ID: <20120318092241.GA23839@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely wrote:
> On Thu, 15 Mar 2012 11:27:36 +0100, Thierry Reding <thierry.reding@avionic-design.de> wrote:
> > So if we decide to explicitly allow specifying names, then we can always add
> > a pwm-names property (or <name>-pwm-names respectively) to use as label and
> > fallback to the user OF device node name if that property is not present.
> 
> After implementing both schemes (ie. interrupts+interrupt-names && [*-]gpios)
> I definitely prefer the fixed property name plus a separate names property.
> It is easier to use common code with that scheme, and easier to statically
> check for correctness.

Okay. Would everyone be happy with "pwms" and "pwm-names"?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120318/eedcc819/attachment.sig>
