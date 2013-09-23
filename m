From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 23 Sep 2013 16:53:52 +0400
Subject: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
In-Reply-To: <20130922215107.GD27616@mtj.dyndns.org>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-9-git-send-email-rogerq@ti.com>
 <20130922165817.GD30946@htj.dyndns.org> <523F35E4.6050707@cogentembedded.com>
 <20130922215107.GD27616@mtj.dyndns.org>
Message-ID: <524039E0.2060205@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-09-2013 1:51, Tejun Heo wrote:

>>     Not sure why you asked -- I'm not using this driver, neither I'm

> Well, you have better grip of what's going on in the embedded world
> than me.  I'm mostly curious whether adding dependency on PHY is okay.

    This driver already supports optional clock, the optional PHY support
seems analogous.

> Thanks.

WBR, Sergei
