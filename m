From: rogerq@ti.com (Roger Quadros)
Date: Wed, 30 Jan 2013 15:15:21 +0200
Subject: [PATCH v2 00/30] USB: omap-ehci: Move PHY management to PHY driver
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA95E60@DBDE01.ent.ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA95DF0@DBDE01.ent.ti.com>
 <510916B2.7080509@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EA95E60@DBDE01.ent.ti.com>
Message-ID: <51091CE9.1020608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2013 03:12 PM, Mohammed, Afzal wrote:
> Hi Roger,
> 
> On Wed, Jan 30, 2013 at 18:18:50, Quadros, Roger wrote:
>> On 01/30/2013 02:08 PM, Mohammed, Afzal wrote:
> 
>>> Please try to ensure that beagle bone USB0 works with this.
> 
>> I do not have beaglebone with me and don't seem to find beaglebone
>> board support in mainline.
> 
> Ok. Fyi, beagle bone is supported in mainline - it is dt boot

OMAP USB host is not yet supported for DT boot in mainline. I'm working on this
at the moment.

cheersm
-roger
