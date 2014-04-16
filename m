From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Apr 2014 21:50:01 +0100
Subject: [PATCH 5/6] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <5094962.iM2Kd6gfjd@wuerfel>
References: <1397554134-11827-1-git-send-email-sachin.kamat@linaro.org>
 <CAJuA9ajXa+mejdUvWATHjmmin8hoRhX0wueg5g8rDbJR4AWZ7A@mail.gmail.com>
 <534E9AA3.10409@samsung.com> <5094962.iM2Kd6gfjd@wuerfel>
Message-ID: <20140416205001.GY12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 08:14:27PM +0200, Arnd Bergmann wrote:

> This patch does a partial revert of 313367e7bfa by allowing these
> drivers on all samsung platforms except EXYNOS, so we can proceed
> with the multiplatform patches.

> If support for these drivers is actually needed on EXYNOS machines,
> the drivers should first be moved over to use the dmaengine code.

I would be surprised if neither IP is present on any Exynos SoC, they
were added in the s5p range.  Is Sachin's fix for building these
(present in -rc1) not doing the job?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140416/9ef060de/attachment.sig>
