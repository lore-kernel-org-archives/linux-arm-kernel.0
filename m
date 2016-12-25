From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 25 Dec 2016 14:51:46 +0200
Subject: [PATCH 3/9] pinctrl: samsung: Remove dead code
In-Reply-To: <1482495889-6201-4-git-send-email-m.szyprowski@samsung.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122524epcas1p4f0235bcdabe1e7bffa141e0b2e32de7f@epcas1p4.samsung.com>
 <1482495889-6201-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20161225125146.xfuhy24ceg2jxhfx@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2016 at 01:24:43PM +0100, Marek Szyprowski wrote:
> 'enable' parameter has been removed a while ago, so all code for handling
> it can be simply removed.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
