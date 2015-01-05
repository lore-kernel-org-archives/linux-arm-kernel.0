From: hong-rong.hsu@mediatek.com (hong-rong hsu)
Date: Mon, 5 Jan 2015 18:12:02 +0800
Subject: Use armv8 instructions to optimize ARM32 crypto
Message-ID: <1420452722.4402.70.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We are engineers from Mediatek. We have a patch to optimize ARM32 kernel
crypto performance by armv8 instructions. Do you have interest in it?

It may be helpful for some projects which running 32-bit kernel at
armv8. Do you suggest that we maintain it at the main-stream :-)? (ex.
add aes-armv8.S in arch/arm/crypto/ folder)

Thanks.
