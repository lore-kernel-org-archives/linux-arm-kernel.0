From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 5 Oct 2017 13:08:20 +0200
Subject: [PATCH v2 2/2] dt-bindings: i2c: Update documentation for
 "mv78230-a0-i2c"
In-Reply-To: <87k20dmxw0.fsf@free-electrons.com>
References: <20170928213605.22874-1-kalyan.kinthada@alliedtelesis.co.nz>
 <20170928213605.22874-3-kalyan.kinthada@alliedtelesis.co.nz>
 <87k20dmxw0.fsf@free-electrons.com>
Message-ID: <20171005110820.phcjh7dmygi43dhq@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 04:23:43PM +0200, Gregory CLEMENT wrote:
> Hi Wolfram,
>  
>  On ven., sept. 29 2017, Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz> wrote:
> 
> > This commit modifies the documentation for
> > "marvell,mv78230-a0-i2c" compatible string.
> >
> > The "marvell,mv78230-a0-i2c" compatible string enables the workaround
> > for an i2c repeated start timing violation, but unlike
> > "marvell,mv78230-i2c" it disables the i2c offload support. This is
> > applicable to a number of SoCs such as early revisions of the Armada XP
> > and the Armada 38x.
> >
> > Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
> 
> 
> I applied the dt fix on my mvebu/fixes branch. Do you want to apply this
> one on your branch, or do you prefer I take it. In this case an acked-by
> would be nice.

I'd prefer to take it. What I'd really like to see here is an ack from
Rob because of the previous discussion of an earlier revision of this
patch.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171005/f264e77f/attachment.sig>
