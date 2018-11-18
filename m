From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Nov 2018 15:29:53 -0800
Subject: [PATCH] ARM: dts: qcom: Remove Arrow SD600 eval board
In-Reply-To: <1542310510-21964-1-git-send-email-andy.gross@linaro.org>
References: <1542310510-21964-1-git-send-email-andy.gross@linaro.org>
Message-ID: <CAOesGMhGYyCT0Tyz7ajOeY-QBM5DMAWt8qzEeJ7N8s+_24cxmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 11:35 AM Andy Gross <andy.gross@linaro.org> wrote:
>
> This patch removes support for the APQ8064 based Arrow SD600 eval
> board.  This board was never sold publicly and had very limited
> distribution.  As such, we are removing this board and no longer
> going to support it.
>
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

It's currently throwing DTS warnings as well, so if nobody's
interested in keeping it around, this seems OK with me.

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
