From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 13 Jun 2014 10:23:28 +0300
Subject: [PATCH v8 0/6] efuse driver for Tegra
In-Reply-To: <539A26DE.8050609@wwwdotorg.org>
References: <1402587400-1544-1-git-send-email-pdeschrijver@nvidia.com>
 <539A26DE.8050609@wwwdotorg.org>
Message-ID: <20140613072328.GK5961@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 12:17:02AM +0200, Stephen Warren wrote:
> On 06/12/2014 09:36 AM, Peter De Schrijver wrote:
> > This driver allows userspace to read the raw efuse data. Its userspace
> > interface is modelled after the sunxi_sid driver which provides similar
> > functionality for some Allwinner SoCs. It has been tested on
> > Tegra20 (ventana), Tegra30 (beaverboard), Tegra114 (dalmore) and
> > Tegra124 (jetson TK1).
> 
> I think this series looks OK now. However, I noticed one change in
> behaviour that I don't think is expected:
> 
> The current code/DTB print:
> Tegra Revision: A01 SKU: 0 CPU Process: 0 Core Process: 0
> 
> However, applying these patches and booting yields:
> Tegra Revision: A01 SKU: 0 CPU Process: 1 Core Process: 1
> 

On which board/SoC?

Cheers,

Peter.
