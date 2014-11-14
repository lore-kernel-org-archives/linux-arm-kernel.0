From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 14 Nov 2014 16:24:18 +0200
Subject: [PATCH v5 1/5] dt-bindings: simplefb: Specify node location and
 handoff related properties
In-Reply-To: <1415962996-31712-1-git-send-email-hdegoede@redhat.com>
References: <1415962996-31712-1-git-send-email-hdegoede@redhat.com>
Message-ID: <54661092.6020907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/14 13:03, Hans de Goede wrote:
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
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Ok, so I have pushed this and the other simplefb series to fbdev for-next.

I can still refresh the whole series if need be, but if possible I'd
rather take any new changes as patches on top of the current ones.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/69d73f87/attachment-0001.sig>
