From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 25 Oct 2018 13:44:06 -0300
Subject: [PATCH V2 6/8] dts: imx: add common imx7ulp dtsi support
In-Reply-To: <1540295058-26090-7-git-send-email-aisheng.dong@nxp.com>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAOMZO5ArziSkimJvKMFPR-RZwWywLmzjpmvAFT9fB0fp_J_YZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 8:55 AM A.s. Dong <aisheng.dong@nxp.com> wrote:

> +               gpio_ptc: gpio at 40ae0000 {
> +                       compatible = "fsl,vf610-gpio";

This should be:

compatible = "fsl,imx7ulp-gpio", "fsl,vf610-gpio";
