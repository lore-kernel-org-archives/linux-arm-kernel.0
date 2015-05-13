From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 May 2015 16:16:52 +0100
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <55536719.5050208@ti.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <554FFFA3.1060801@ti.com> <20150512051633.GB32300@linux>
 <555224A2.7000308@ti.com> <20150513050559.GE28858@linux>
 <55536719.5050208@ti.com>
Message-ID: <20150513151652.GX2761@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 10:00:41AM -0500, Nishanth Menon wrote:

> What I dont see in the thread, and the point I raised here, why have
> nominal/typical voltage at all? min<->max should be sufficient,
> correct? If the device cannot function at min, then it should not be
> documented as part of valid range at all.

Going for the minimum specified voltage is asking for trouble with
regard to tolerances and so on, see also your concern about process
corners.  If the electrical engineers specify things as X +/- Y the
most conservative thing to do is to try to hit X rather than going
straight for the limits.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/e496afd3/attachment.sig>
