From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 26 Dec 2016 14:40:46 +0900
Subject: [PATCH 3/9] pinctrl: samsung: Remove dead code
In-Reply-To: <1482495889-6201-4-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161223122524epcas1p4f0235bcdabe1e7bffa141e0b2e32de7f@epcas1p4.samsung.com>
 <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <1482495889-6201-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CA+Ln22GY6cG6Hmg1KKgt-+yP7v5W4+PSZyPTnW4wAcxTZAmRbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2016-12-23 21:24 GMT+09:00 Marek Szyprowski <m.szyprowski@samsung.com>:
> 'enable' parameter has been removed a while ago, so all code for handling
> it can be simply removed.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
