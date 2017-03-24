From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Fri, 24 Mar 2017 15:55:22 +0100
Subject: [PATCH 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <20170324145156.miqmxgkhn2v7rbcu@kozik-lap>
References: <20170324142446.31129-1-krzk@kernel.org>
 <3628768.ze2UxnIp5I@tauon.atsec.com>
 <20170324145156.miqmxgkhn2v7rbcu@kozik-lap>
Message-ID: <2090327.CHzkLTTdtg@positron.chronox.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 24. M?rz 2017, 15:51:56 CET schrieb Krzysztof Kozlowski:

Hi Krzysztof,
> 
> I'll use the generated random numbers.

If you do that, may I propse that you update this seed field periodically? 
E.g. with every (or every other) user request for random data, you may update 
that field with new data.

Ciao
Stephan
