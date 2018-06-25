From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Jun 2018 09:26:16 -0300
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <20180625121813.rzqgzdbk6ue73eq4@earth.universe>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
 <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
 <CAOMZO5CumdNSP6iTfgXPdmpcZwh7YmBstUpAmb3A1QAf1UWJdw@mail.gmail.com>
 <CAHQ1cqHpNvZGAfFKrp-OiZevsha5CBwJsw8GT+uhgNSfEUejkw@mail.gmail.com>
 <CAOMZO5DAbooRgA+sHJa5EmEGy-CHW3FPydcOFtK5AqpdJzD7MQ@mail.gmail.com>
 <20180625121813.rzqgzdbk6ue73eq4@earth.universe>
Message-ID: <CAOMZO5B_tVj8niY10m2Q1vnr3Az74pwX+BgTo0DaN+PdM4xTYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Mon, Jun 25, 2018 at 9:18 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:

> I still have access to the imx53 based PPD from General Electric.
> But I don't understand what patch you want me to test. FWIW the
> images I use(d) for testing already had CONFIG_USB_CHIPIDEA_ULPI
> and CONFIG_USB_ULPI_BUS enabled.

I was referring to the patch that enables CONFIG_USB_CHIPIDEA_ULPI and
CONFIG_USB_ULPI_BUS.

Will submit this change as suggested by Andrey.

Regards,

Fabio Estevam
