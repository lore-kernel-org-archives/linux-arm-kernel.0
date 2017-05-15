From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 15 May 2017 19:04:53 +0200
Subject: [PATCH 2/2] pinctrl: samsung: remove unneeded (void *) casts in
 of_match_table
In-Reply-To: <1493156063-8446-3-git-send-email-yamada.masahiro@socionext.com>
References: <1493156063-8446-1-git-send-email-yamada.masahiro@socionext.com>
 <1493156063-8446-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170515170453.s6ie5bu7o6o4dz6g@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 06:34:23AM +0900, Masahiro Yamada wrote:
> of_device_id::data is an opaque pointer.  No explicit cast is needed.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
