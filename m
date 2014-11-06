From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Nov 2014 06:07:16 +0000
Subject: [PATCHv0 3/3] rtc: rtc-isl12057: add alarm support to Intersil
 ISL12057 RTC driver
In-Reply-To: <545B0E53.4020003@roeck-us.net>
References: <cover.1415222752.git.arno@natisbad.org>
 <148403c0ab1d556cbb99d9242c65f714a77843e5.1415222752.git.arno@natisbad.org>
 <20141106055017.GL8509@sirena.org.uk>
 <545B0E53.4020003@roeck-us.net>
Message-ID: <20141106060716.GS8509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 09:59:47PM -0800, Guenter Roeck wrote:
> On 11/05/2014 09:50 PM, Mark Brown wrote:

> >I can't help but think that toggle is a confusing name for this.
> >enable?

> If I recall correctly we had this argument before. Problem is that the
> function can also _disable_ the alarm, so to name it enable is just
> as misleading or confusing. update_alarm, maybe ?

update seems reasonable, yes.  toggle I'd expect to invert the state.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/f4bbde01/attachment.sig>
