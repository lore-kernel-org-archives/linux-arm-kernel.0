From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 19 Jun 2015 18:01:27 +0200
Subject: [PATCH v4 1/3] clk: Add regmap support
In-Reply-To: <1434464615-9080-2-git-send-email-matthias.bgg@gmail.com>
References: <1434464615-9080-1-git-send-email-matthias.bgg@gmail.com>
 <1434464615-9080-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <CAGhQ9Vx3qxvawiUYtEjr7z=o6mS3TirCzRd9-UZ0FP=equWEaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On 16 June 2015 at 16:23, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> Some devices like SoCs from Mediatek need to use the clock
> through a regmap interface.
> This patch adds regmap support for the simple multiplexer clock,
> the divider clock and the clock gate code.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

I think it looks fine now and I have no further comments, so:
Acked-by: Joachim Eastwood <manabian@gmail.com>

Hope this can go in for 4.3.


regards,
Joachim Eastwood
