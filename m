From: broonie@kernel.org (Mark Brown)
Date: Fri, 10 Oct 2014 14:48:05 +0100
Subject: [PATCH 2/2] regulator: twl: use platform data in the DT based
 boot also
In-Reply-To: <5437E28E.8020500@ti.com>
References: <1412948442-19896-1-git-send-email-t-kristo@ti.com>
 <1412948442-19896-3-git-send-email-t-kristo@ti.com>
 <5437E28E.8020500@ti.com>
Message-ID: <20141010134805.GF18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 04:43:42PM +0300, Tero Kristo wrote:
> On 10/10/2014 04:40 PM, Tero Kristo wrote:
> >This allows to pass platform information during a DT boot also, currently
> >this is completely ignored. Needed for supporting the platform specific
> >regulator set_voltage / get_voltage ops for the SMPS regulators.
> >
> >Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >To: Liam Girdwood <lgirdwood@gmail.com>
> >To: Mark Brown <broonie@kernel.org>
> 
> Ok that "To:" didn't really work too well, added manually. Can repost if
> needed.

I can't apply a quoted reply so yes please.  I'm also not seeing patch
1.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/b7592177/attachment.sig>
