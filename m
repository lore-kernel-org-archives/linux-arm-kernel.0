From: corbet@lwn.net (Jonathan Corbet)
Date: Fri, 10 Jul 2015 14:00:04 -0600
Subject: [PATCH] Documentation: ARM: EXYNOS: Extend boot loader
 interface documentation
In-Reply-To: <1436065011-6999-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1436065011-6999-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150710140004.5b1a8a45@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  5 Jul 2015 11:56:51 +0900
Krzysztof Kozlowski <k.kozlowski.k@gmail.com> wrote:

> Extend the kernel-bootloader interface documentation with usage of
> register INFORM1 (0x0804) and different CPU resume address on Exynos542x
> family (with Multi-Cluster Power Management enabled).

I have to assume that the new info here is correct...hopefully somebody
will scream if that's not true.  Applied to the docs tree, thanks.

jon
