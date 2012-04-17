From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Apr 2012 19:38:29 +0100
Subject: [PATCH v4 2/2] regulator: add device tree support for max8997
In-Reply-To: <CAJuYYwRsHynt6pBHUgk72Z-UjHj3DM=s4pV4dzbb2hTAZOUSAw@mail.gmail.com>
References: <1332582590-16382-1-git-send-email-thomas.abraham@linaro.org>
 <1332582590-16382-3-git-send-email-thomas.abraham@linaro.org>
 <4F734460.4060605@samsung.com>
 <CAJuYYwRsHynt6pBHUgk72Z-UjHj3DM=s4pV4dzbb2hTAZOUSAw@mail.gmail.com>
Message-ID: <20120417183829.GW6652@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 12:05:59AM +0530, Thomas Abraham wrote:
> On 28 March 2012 22:33, Karol Lewandowski <k.lewandowsk@samsung.com> wrote:

> >> + ? ?For BUCK's:

No 's here, BTW.

> > ?- EN32KHz_AP
> > ?- EN32KHz_CP
> > ?- ENVICHG
> > ?- ESAFEOUT1
> > ?- ESAFEOUT2
> > ?- CHARGER
> > ?- CHARGER_CV
> > ?- CHARGER_TOPOFF

> > I wonder if these should be mentioned in documentation too.

> Yes, I missed the above regulators in the documentation. I have
> included them now and will resubmit this patch.

Please omit the clocks; these are obviously a bodge due to the inability
to support clocks off-SoC so we shouldn't be enshrining them in the
device tree bindings.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120417/9df2abff/attachment-0001.sig>
