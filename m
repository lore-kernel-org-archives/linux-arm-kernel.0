From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 26 Apr 2017 09:21:45 +0200
Subject: [PATCH 2/2] pinctrl: samsung: remove unneeded (void *) casts in
 of_match_table
In-Reply-To: <1493156063-8446-3-git-send-email-yamada.masahiro@socionext.com>
References: <1493156063-8446-1-git-send-email-yamada.masahiro@socionext.com>
 <1493156063-8446-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAJKOXPdfYjBw=LSfLOJ_CY2+bhY5QA--GbUHfqz3yBuydsO8Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 11:34 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> of_device_id::data is an opaque pointer.  No explicit cast is needed.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Looks correct. It is too late for me for v4.12 so I will pick it up
for v4.13. For my reference:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
