From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Mar 2016 11:02:40 +0000
Subject: [PATCH] ARM: dts: exynos: Fix invalid maximum voltage for buck9
 supplying SD card
In-Reply-To: <CAJKOXPc03ksVFKAHo_Znw41wdzRmzJpFYfAEw2q3EfrQxevghg@mail.gmail.com>
References: <1458807125-13580-1-git-send-email-k.kozlowski@samsung.com>
 <20160324095332.GS2566@sirena.org.uk>
 <CAJKOXPc03ksVFKAHo_Znw41wdzRmzJpFYfAEw2q3EfrQxevghg@mail.gmail.com>
Message-ID: <20160324110240.GU2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 07:25:35PM +0900, Krzysztof Kozlowski wrote:

> I'll look at it after weekend. For now I applied my patch to the
> for-next, so the next should be fixed.

Oh, and please send this to Linus - the regulator change is fixing a
problem some other boards noticed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160324/557c1498/attachment.sig>
