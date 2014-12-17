From: lznuaa@gmail.com (Zhi Li)
Date: Wed, 17 Dec 2014 15:46:23 -0600
Subject: i.mx6sx halt when enable qspi
Message-ID: <CAHrpEqSVD3LK_O1iu-9ANZy54TFWHHMe7=AA9FDsboWeiX86yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn:

          we try to upstream some qspi patch.
          but I found system halt at clk_set_rate in function
fsl_qspi_nor_setup_last

          Do you have idea about why halt when change clk rate?

best regards
Frank Li
