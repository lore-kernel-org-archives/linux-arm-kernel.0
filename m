From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Aug 2013 01:35:57 +0100
Subject: Broken device trees for exynos in linux-next
In-Reply-To: <13b101ce9a14$2cebd700$86c38500$@org>
References: <CAOesGMgv9gTQ_NtaKZY_ZfLD1NBU19E-vaLaWwmvGJJB1MQrwg@mail.gmail.com>
 <13b101ce9a14$2cebd700$86c38500$@org>
Message-ID: <20130816003557.GJ30073@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 09:04:28AM +0900, Kukjin Kim wrote:

> NO, the build breakage is due to commit 6187288f15bc ("ARM: dts: exynos5250:
> move common i2s properties to exynos5 dtsi" which is in Mark Brown's tree.

> Mark, pleaser revert it in your tree...

I'll do that but I don't know if that's then going to break anything
else.  This sort of bisection/cross tree issue does come up a lot with
the Samsung SoCs - it'd be good if you could remind the people working
on them about the need to make sure that when there are dependencies
they're handled when things are merged.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130816/846e6eb2/attachment.sig>
