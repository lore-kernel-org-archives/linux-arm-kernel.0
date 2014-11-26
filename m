From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 26 Nov 2014 17:31:46 +0100
Subject: [PATCH v2 0/5] Fix Arndale Octa/Peach Pi boot on Audio subsystem
 clocks
In-Reply-To: <1417011857-10419-1-git-send-email-k.kozlowski@samsung.com>
References: <1417011857-10419-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54760072.8010307@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 11/26/2014 03:24 PM, Krzysztof Kozlowski wrote:
> Description
> ===========
> This patchset tries to solve dependency between AudioSS components
> (clocks and GPIO) and main clock controller on Exynos platform.
> 
> This solves boot failure of Peach Pi/Pit and Arndale Octa [1].
> 

I tested and patches #2, #3, #4 solves the boot failure I was facing.
So for the whole series on an Exynos5420 Peach Pit:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Thanks a lot for solving this issue.

Best regards,
Javier
