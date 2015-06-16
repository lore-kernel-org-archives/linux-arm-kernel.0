From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 16 Jun 2015 16:12:49 -0700
Subject: [PATCH] Documentation: ARM: EXYNOS: Describe boot loaders
 interface
In-Reply-To: <1433585151-3627-1-git-send-email-k.kozlowski.k@gmail.com>
 (Krzysztof Kozlowski's message of "Sat, 6 Jun 2015 19:05:51 +0900")
References: <1433585151-3627-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <7hlhfjw8lq.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski <k.kozlowski.k@gmail.com> writes:

> Various boot loaders for Exynos based boards use certain memory
> addresses during booting for different purposes. Mostly this is one of
> following :
> 1. as a CPU boot address,
> 2. for storing magic cookie related to low power mode (AFTR, sleep).
>
> The document, based solely on kernel source code, tries to group the
> information scattered over different files. This would help in the
> future when adding support for new SoC or when extending features
> related to low power modes.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Very nice, thank you for taking the time to pull all of this together
into one location.

Kevin
