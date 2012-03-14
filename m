From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 14 Mar 2012 16:20:05 +0800
Subject: [PATCH] pxa/hx4700: Remove unwanted request for GPIO105
In-Reply-To: <1331644290.41945.YahooMailClassic@web29009.mail.ird.yahoo.com>
References: <1331644290.41945.YahooMailClassic@web29009.mail.ird.yahoo.com>
Message-ID: <CAN1soZwB0aRvLROtJ64pmuJCRb7EVT+g7BLL2uVLw8QRCofu5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 9:11 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> GPIO105 (nIR_ON) is requested twice: first in gpio_request_array(), then in
> pxa_irda_probe(). Consequently the second request fails with EBUSY:
>
> pxa2xx-ir: probe of pxa2xx-ir failed with error -16
>
> This patch removes the first request, allowing pxa_irda_probe() to succeed.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---

Applied
