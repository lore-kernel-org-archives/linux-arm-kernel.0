From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 2 Jan 2018 13:32:02 -0200
Subject: [PATCH 1/2] ARM: dts: imx6ul: add 696MHz operating point
In-Reply-To: <E5B0DB53-D0E5-430B-BBCC-EF3899C70DAE@nxp.com>
References: <1514912859-17691-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5C-qgyCJPBHYwjD9zjHqu4eoGDfoB5-BcFdnvSy01MKiQ@mail.gmail.com>
 <E5B0DB53-D0E5-430B-BBCC-EF3899C70DAE@nxp.com>
Message-ID: <CAOMZO5BGmnNzv7YobtB+KOi0PM+qzyYi97q_NZtT1PU_e+Bcbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 1:12 PM, Anson Huang <anson.huang@nxp.com> wrote:

> There is a comment in VDD_ARM, VDD_SOC must NOT lower than VDD_ARM.
>
> Output voltage must be set to the following rules:
> ? VDD_ARM_CAP <= VDD_SOC_CAP
> ? VDD_SOC_CAP - VDD_ARM_CAP < 330 mV

Thanks for the clarifcation.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
