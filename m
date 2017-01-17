From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 17 Jan 2017 19:38:20 +0200
Subject: [PATCH v2 09/13] pinctrl: samsung: Use generic
 of_device_get_match_data helper
In-Reply-To: <1484657084-26227-10-git-send-email-m.szyprowski@samsung.com>
References: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124501eucas1p101d1468371db26b0244854e36281b9c9@eucas1p1.samsung.com>
 <1484657084-26227-10-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170117173820.znzpnxkaglhk4yfa@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 01:44:40PM +0100, Marek Szyprowski wrote:
> Replace custom code with generic helper.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
