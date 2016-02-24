From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 14:25:30 -0800
Subject: [GIT PULL 4/7] ARM: EXYNOS: mach/soc changes for v4.6
In-Reply-To: <1455496446-23779-5-git-send-email-k.kozlowski@samsung.com>
References: <1455496446-23779-1-git-send-email-k.kozlowski@samsung.com>
 <1455496446-23779-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160224222530.GV10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 09:34:03AM +0900, Krzysztof Kozlowski wrote:
> Hi Arnd, Kevin and Olof,
> 
> This pulls previous tags (early DT changes, movement of SROM/PMU
> to drivers/soc) and contains other interesting stuff. Description
> along with a tag.
> 
> Kind regards,
> Krzysztof

Hi,

This shares most of the contents with the drivers/soc branch (the previous
one).

It's useful to get just the incremental delta instead of the full one, so we
can see what's new in this branch compared to the previous one.

Generating that delta is a little awkward, but you can tell git request-pull
about the different base. If you don't have backmerges since then it should
generate the right diffstat.

Holding off on this branch due to the feedback on the previous one.


-Olof
