From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 25 Nov 2014 14:34:19 +0200
Subject: [PATCH v3 0/2] dt-bindings: simplefb: Drop the advice about using
 a specific path for nodes
In-Reply-To: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
References: <1416309051-26784-1-git-send-email-hdegoede@redhat.com>
Message-ID: <5474774B.7080408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18/11/14 13:10, Hans de Goede wrote:
> Hi Tomi,
> 
> So it turns out we needed a v3, as I mistakenly went with "sunxi," as vendor
> prefix for the allwinner specific properties, but the registered vendor prefix
> for allwinner is "allwinnner,", this version fixes this.
> 
> Changes in v3: Use proper "allwinnner," for the compatible string and vendor
> specific properties.
> 
> Changes in v2: Changed the simplefb-sunxi bindings to use a single
> sunxi,pipeline string property instead of a sunxi,pipeline int and a
> sunxi,output string property.
> 
> This patch set is all acked up, and a fix to the binding changes you've
> already queued for 3.19, so please queue these 2 patches for 3.19.

The discussions about this have continued in the earlier version of this
series. Is this series still ok for everyone?

The series looks fine to me, and has Grant's acks, so I'll merge it
tomorrow to fbdev tree if no one objects (and my comment for the patch 2
about sunxi/allwinner was just my ignorance).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141125/7bff74e9/attachment-0001.sig>
