From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 24 May 2017 09:13:10 -0300
Subject: [PATCH] ARM: dts: imx6: use #include "..." to include local DT
In-Reply-To: <1495602162-14672-1-git-send-email-yamada.masahiro@socionext.com>
References: <1495602162-14672-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAOMZO5CLtPpPuE2gj3=RMyF98_J9q_gfmgM5d3U_8nA7umeCQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 2:02 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Most of DT files in ARM use #include "..." to make pre-processor
> include DT in the same directory, but we have some exceptional files
> that use #include <...> for that.
>
> Fix them to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts path from
> dtc_cpp_flags.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
