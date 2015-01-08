From: hong-rong.hsu@mediatek.com (hong-rong hsu)
Date: Thu, 8 Jan 2015 21:29:54 +0800
Subject: Use armv8 instructions to optimize ARM32 crypto
In-Reply-To: <1420452722.4402.70.camel@mtksdaap41>
References: <1420452722.4402.70.camel@mtksdaap41>
Message-ID: <1420723794.21522.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Excuse me, add more reviewers.

On Mon, 2015-01-05 at 18:12 +0800, hong-rong hsu wrote:
> Hi,
> 
> We are engineers from Mediatek. We have a patch to optimize ARM32 kernel
> crypto performance by armv8 instructions. Do you have interest in it?
> 
> It may be helpful for some projects which running 32-bit kernel at
> armv8. Do you suggest that we maintain it at the main-stream :-)? (ex.
> add aes-armv8.S in arch/arm/crypto/ folder)
> 
> Thanks.
