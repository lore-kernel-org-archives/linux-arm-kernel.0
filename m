From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 Dec 2014 19:53:15 -0200
Subject: i.mx6sx halt when enable qspi
In-Reply-To: <CAHrpEqSVD3LK_O1iu-9ANZy54TFWHHMe7=AA9FDsboWeiX86yQ@mail.gmail.com>
References: <CAHrpEqSVD3LK_O1iu-9ANZy54TFWHHMe7=AA9FDsboWeiX86yQ@mail.gmail.com>
Message-ID: <CAOMZO5BbcYY7zZauFTeVfX1YHUN-=-iU1uG+Jh3e3CLkKV5eRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On Wed, Dec 17, 2014 at 7:46 PM, Zhi Li <lznuaa@gmail.com> wrote:
> Shawn:
>
>           we try to upstream some qspi patch.
>           but I found system halt at clk_set_rate in function
> fsl_qspi_nor_setup_last
>
>           Do you have idea about why halt when change clk rate?

You need to apply this patch:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/311067.html

Please try this series.
