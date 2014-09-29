From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 29 Sep 2014 17:47:48 -0400
Subject: [PATCH v5 2/3] net: Add Keystone NetCP ethernet driver
In-Reply-To: <20140929.161253.1302757975839499212.davem@davemloft.net>
References: <1411667317-1163-3-git-send-email-santosh.shilimkar@ti.com>	<20140929.155200.2231132602322345812.davem@davemloft.net>	<5429BAD0.1050101@ti.com>
 <20140929.161253.1302757975839499212.davem@davemloft.net>
Message-ID: <5429D384.1040909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 September 2014 04:12 PM, David Miller wrote:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Mon, 29 Sep 2014 16:02:24 -0400
> 
>> We are badly missing mainline network driver support for the Keystone
>> and hence I request you to help here.
> 
> It is absolutely not reasonable for you depend specifically upon me
> for top-level review of a given change, sorry.
> 
Sorry I didn't mean you specifically to review everything. But a guidance
on how we can move forward. If you can suggest someone, we can try to
request them to have a look. The design of driver is just now standard
NIC card. We removed the controversial plug in framework after your
and Jamal's suggestion. Jamal already commented on the offload design of
the driver and we addressed them in the last version.

We can follow it up on any comments, suggestions quickly so do let us
know.

Regards,
Santosh
