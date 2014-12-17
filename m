From: lznuaa@gmail.com (Zhi Li)
Date: Wed, 17 Dec 2014 15:53:28 -0600
Subject: i.mx6sx halt when enable qspi
In-Reply-To: <CAHrpEqSVD3LK_O1iu-9ANZy54TFWHHMe7=AA9FDsboWeiX86yQ@mail.gmail.com>
References: <CAHrpEqSVD3LK_O1iu-9ANZy54TFWHHMe7=AA9FDsboWeiX86yQ@mail.gmail.com>
Message-ID: <CAHrpEqR0fWwsimJ4yA5o_47tCHJjSHPmXnXNk0A6jwa5s2-saA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 3:46 PM, Zhi Li <lznuaa@gmail.com> wrote:
> Shawn:
>
>           we try to upstream some qspi patch.
>           but I found system halt at clk_set_rate in function
> fsl_qspi_nor_setup_last
>
>           Do you have idea about why halt when change clk rate?

I forget maintain. I base on linux-next
15229b5a1674f7096a547f590f2c70a2a86ae744

>
> best regards
> Frank Li
