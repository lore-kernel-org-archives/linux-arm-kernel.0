From: rogerq@ti.com (Roger Quadros)
Date: Mon, 23 Sep 2013 10:37:38 +0300
Subject: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
In-Reply-To: <20130922215107.GD27616@mtj.dyndns.org>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-9-git-send-email-rogerq@ti.com>
 <20130922165817.GD30946@htj.dyndns.org> <523F35E4.6050707@cogentembedded.com>
 <20130922215107.GD27616@mtj.dyndns.org>
Message-ID: <523FEFC2.801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

On 09/23/2013 12:51 AM, Tejun Heo wrote:
> Hello,
> 
> On Sun, Sep 22, 2013 at 10:24:36PM +0400, Sergei Shtylyov wrote:
>>    Not sure why you asked -- I'm not using this driver, neither I'm
> 
> Well, you have better grip of what's going on in the embedded world
> than me.  I'm mostly curious whether adding dependency on PHY is okay.
> 

There is no hard dependency on presence of PHY. The driver will continue
as usual if devm_phy_get() fails.
I hope selecting GENERIC_PHY in Kconfig is not an issue.

cheers,
-roger
