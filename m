From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 24 Mar 2017 17:58:18 +0300
Subject: [PATCH 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <2090327.CHzkLTTdtg@positron.chronox.de>
References: <20170324142446.31129-1-krzk@kernel.org>
 <3628768.ze2UxnIp5I@tauon.atsec.com>
 <20170324145156.miqmxgkhn2v7rbcu@kozik-lap>
 <2090327.CHzkLTTdtg@positron.chronox.de>
Message-ID: <20170324145818.3muyy4cq3gms5len@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 03:55:22PM +0100, Stephan M?ller wrote:
> Am Freitag, 24. M?rz 2017, 15:51:56 CET schrieb Krzysztof Kozlowski:
> 
> Hi Krzysztof,
> > 
> > I'll use the generated random numbers.
> 
> If you do that, may I propse that you update this seed field periodically? 
> E.g. with every (or every other) user request for random data, you may update 
> that field with new data.

Sounds reasonable. Thanks for feedback, it is much appreciated.

Best regards,
Krzysztof
