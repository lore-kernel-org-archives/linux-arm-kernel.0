From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 10 Aug 2016 15:08:05 +0200
Subject: [RFT RESEND PATCH v3 2/3] ARM: Fix *MIGHT_HAVE_PCI* config from
 being selected redundantly
In-Reply-To: <1470832400-11929-3-git-send-email-kishon@ti.com>
References: <1470832400-11929-1-git-send-email-kishon@ti.com>
 <1470832400-11929-3-git-send-email-kishon@ti.com>
Message-ID: <e2e7e471-190d-a685-e496-1ab3e1d3a333@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2016 02:33 PM, Kishon Vijay Abraham I wrote:
> *MIGHT_HAVE_PCI* config is already selected in ARCH_MULTIPLATFORM.
> Fix it from getting redundantly selected in all

I don't like the "fix" here and in subject. There is no error, no
warning, no issue to be fixed. Fix might be a candidate to backport
(stable, vendor etc) but this just removes something which is not needed.

With the change in subject, for exynos:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
