From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 25 Sep 2013 14:16:41 +0200
Subject: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
In-Reply-To: <524039E0.2060205@cogentembedded.com>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <20130922215107.GD27616@mtj.dyndns.org> <524039E0.2060205@cogentembedded.com>
Message-ID: <2926093.ynDRy1bx5J@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, September 23, 2013 04:53:52 PM Sergei Shtylyov wrote:
> Hello.
> 
> On 23-09-2013 1:51, Tejun Heo wrote:
> 
> >>     Not sure why you asked -- I'm not using this driver, neither I'm
> 
> > Well, you have better grip of what's going on in the embedded world
> > than me.  I'm mostly curious whether adding dependency on PHY is okay.
> 
>     This driver already supports optional clock, the optional PHY support
> seems analogous.

Right, this reminds me that PHY support should probably also be added to
ahci_suspend() and ahci_resume().

Also please note the generic PHY framework is not yet merged in Linus'
tree so this patch should probably be merged only after the generic PHY
framework is in.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
