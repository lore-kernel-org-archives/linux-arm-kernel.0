From: peter.chubb@nicta.com.au (Peter Chubb)
Date: Sat, 6 Jun 2015 21:01:00 +1000
Subject: [PATCH] Documentation: ARM: EXYNOS: Describe boot loaders
 interface
In-Reply-To: <1433585151-3627-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1433585151-3627-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <848ubx2j9v.wl-peter.chubb@nicta.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Krzysztof" == Krzysztof Kozlowski <k.kozlowski.k@gmail.com> writes:

Krzysztof> Various boot loaders for Exynos based boards use certain
Krzysztof> memory addresses during booting for different
Krzysztof> purposes. Mostly this is one of following : 1. as a CPU
Krzysztof> boot address, 2. for storing magic cookie related to low
Krzysztof> power mode (AFTR, sleep).

Krzysztof> The document, based solely on kernel source code, tries to
Krzysztof> group the information scattered over different files. This
Krzysztof> would help in the future when adding support for new SoC or
Krzysztof> when extending features related to low power modes.

Is it worth grabbing the info from u=boot and documenting it here
(it's not documented other than in the hardkenel U=Boot source)?

I can send you the info, or you can see it in
https://github.com/hardkernel/u-boot/blob/odroidxu3-v2012.07/board/samsung/smdk5420/lowlevel_init.S
at symbol nscode_base near line 104

-- 
Dr Peter Chubb				        peter.chubb AT nicta.com.au
http://www.ssrg.nicta.com.au          Software Systems Research Group/NICTA
