From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 22 May 2015 12:52:41 -0700
Subject: [RFC PATCH 1/1] pci-imx6: add speed change timeout message
In-Reply-To: <CAOMZO5DjKyxMEc1PaYhd2e-NBacLHGS=YksofUr1js8OoUns0g@mail.gmail.com>
References: <1432233345-10160-1-git-send-email-troy.kisky@boundarydevices.com>	<201505212319.47974.marex@denx.de>	<555E6795.6090009@boundarydevices.com>	<201505220131.23825.marex@denx.de>	<555F6ABE.7000000@boundarydevices.com>
 <CAOMZO5DjKyxMEc1PaYhd2e-NBacLHGS=YksofUr1js8OoUns0g@mail.gmail.com>
Message-ID: <555F8909.2040105@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/22/2015 11:02 AM, Fabio Estevam wrote:
> Hi Troy,
> 
> On Fri, May 22, 2015 at 2:43 PM, Troy Kisky
> <troy.kisky@boundarydevices.com> wrote:
> 
>> This patch breaks my imx6sx board, so it shouldn't be applied until there is
>> an explanation and work around of some sort.
> 
> Do you have mx6sx PCI working with mainline or only with FSL 3.14 kernel?
> 
> Regards,
> 
> Fabio Estevam
> 

Your right, mainline does not support pcie for imx6sx yet, so the patch will not cause
a regression. I saw pcie in imx6sx.dtsi and assumed it did. I guess whoever adds imx6sx
support can figure it out.

Thanks
Troy
