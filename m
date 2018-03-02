From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 2 Mar 2018 09:43:21 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_SND_SOC_WM8962
 explicitly
In-Reply-To: <20180302085502.GA9596@Asurada>
References: <1519931336-9710-1-git-send-email-festevam@gmail.com>
 <20180302085502.GA9596@Asurada>
Message-ID: <CAOMZO5DjiNTeougH5P8rW30RzCdOkxiVY5vOGR-T_e2WLiJ7eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolin,

On Fri, Mar 2, 2018 at 5:55 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> Btw, we may also do this to imx-sgtl5000? I don't have a board
> to verify it though..

I will run some tests on mx25/mx53/mx6 boards with sgtl5000.

If all of them work well with the fsl-asoc-card machine driver, then I
will send a patch removing imx-sgtl5000 as well.
