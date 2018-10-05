From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 5 Oct 2018 23:10:12 +0200
Subject: [PATCH] mmc: meson-mx-sdio: mark expected switch fall-through
In-Reply-To: <20181005100903.GA32057@embeddedor.com>
References: <20181005100903.GA32057@embeddedor.com>
Message-ID: <CAFBinCDWUO74R_GKBJCmGRNSz=b75zxj4XB8LnYuQjdW9ecGLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 12:15 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Notice that in this particular case, I replaced the "fall-through:"
> comment with a proper "fall through", which is what GCC is
> expecting to find.
>
> Addresses-Coverity-ID: 1373880 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

thank you for taking care of this!


Regards
Martin
