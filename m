From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 23 Apr 2014 10:13:05 +0200
Subject: [PATCH 1/6] ata: ahci: add AHCI support for Berlin SoCs
In-Reply-To: <4239617.ieu9uluV2B@amdc1032>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
 <4239617.ieu9uluV2B@amdc1032>
Message-ID: <20140423081305.GA24355@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 22, 2014 at 06:54:27PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Tuesday, April 22, 2014 05:38:20 PM Antoine T?nart wrote:

[?]

> > +static struct platform_driver ahci_berlin_driver = {
> > +	.probe	= ahci_berlin_probe,
> > +	.remove	= ata_platform_remove_one,
> > +	.driver	= {
> > +		.name		= "ahci-berlin",
> > +		.owner		= THIS_MODULE,
> > +		.of_match_table = ahci_berlin_of_match,
> 
> Please add a comment explaining lack of power management support
> (i.e. that your platform doesn't have PM support implemented yet).

I can add the power management support in the v2.

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
