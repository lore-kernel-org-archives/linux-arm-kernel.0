From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 22 May 2015 17:18:39 -0300
Subject: [RFC PATCH 1/1] pci-imx6: add speed change timeout message
In-Reply-To: <555F8909.2040105@boundarydevices.com>
References: <1432233345-10160-1-git-send-email-troy.kisky@boundarydevices.com>
 <201505212319.47974.marex@denx.de>
 <555E6795.6090009@boundarydevices.com>
 <201505220131.23825.marex@denx.de>
 <555F6ABE.7000000@boundarydevices.com>
 <CAOMZO5DjKyxMEc1PaYhd2e-NBacLHGS=YksofUr1js8OoUns0g@mail.gmail.com>
 <555F8909.2040105@boundarydevices.com>
Message-ID: <CAOMZO5A4RXirqtY8gYx2pc2znoL+Cq8=gGzbh+J1Zuf=4-YK+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 22, 2015 at 4:52 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:

> Your right, mainline does not support pcie for imx6sx yet, so the patch will not cause
> a regression. I saw pcie in imx6sx.dtsi and assumed it did. I guess whoever adds imx6sx
> support can figure it out.

Yes, Richard Zhu has made some attemps to add mx6sx PCI support, but
the support is not in place yet.

Maybe you can send your patch without RFC to the linux-pci list as well.

Please add Tim Harvey on Cc as he ran some extensive PCI tests and it
would be good to have him look at your patch as well.

Regards,

Fabio Estevam
