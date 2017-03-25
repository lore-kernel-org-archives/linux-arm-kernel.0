From: smueller@chronox.de (Stephan =?ISO-8859-1?Q?M=FCller?=)
Date: Sat, 25 Mar 2017 17:32:12 +0100
Subject: [PATCH v3 0/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <20170325162654.3827-1-krzk@kernel.org>
References: <20170325162654.3827-1-krzk@kernel.org>
Message-ID: <11209034.TNQDREpKIz@tauon.atsec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 25. M?rz 2017, 17:26:51 CET schrieb Krzysztof Kozlowski:

Hi Krzysztof,

> Hi,
> 
> 
> This is a follow up of my questions around exynos-rng [1].
> 
> Changes since v2:
> =================
> 1. Do not re-use random numbers for re-seed (neither for system resume
>    nor for periodic re-seed).  Instead the driver will just generate new
>    random numbers (suggested by Stephan M?ller).

Thank you. Regarding the cryptographic aspects:

Reviewed-by: Stephan M?ller <smueller@chronox.de>

Ciao
Stephan
