From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Nov 2014 11:45:20 +0100
Subject: [PATCH v2 1/4] dt-bindings: simplefb: Specify node location and
 handoff related properties
In-Reply-To: <1415868610-13297-1-git-send-email-hdegoede@redhat.com>
References: <1415868610-13297-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20141113104520.GG20972@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 09:50:07AM +0100, Hans de Goede wrote:
> Since simplefb nodes do not relate directly to hw typically they have been
> placed in the root of the devicetree. As the represent runtime information
> having them as sub-nodes of /chosen is more logical, specify this.
> 
> Also specify when to set the chosen stdout-path property to a simplefb node.
> 
> For reliable handover to a hardware specific driver, that driver needs to
> know which simplefb to unregister when taking over, specify how the hw driver
> can find the matching simplefb node.
> 
> Last add some advice on how to fill and use simplefb nodes from a firmware
> pov.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/c95bc711/attachment.sig>
