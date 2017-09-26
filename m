From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 26 Sep 2017 23:37:40 +0200
Subject: [PATCH] PM: ARM: sa1111: Drop suspend and resume bus type
 callbacks
In-Reply-To: <20170926212812.GS20805@n2100.armlinux.org.uk>
References: <2654085.Tx1JnNWXkX@aspire.rjw.lan>
 <20170926212812.GS20805@n2100.armlinux.org.uk>
Message-ID: <CAJZ5v0i1iwBpkUYN=DbpbtVDu+xMKwza=4EbjYNyGr5rs7-D8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 11:28 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Sep 26, 2017 at 10:47:10PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> None of the sa1111 drivers in the tree implements the suspend and
>> resume callbacks from struct sa1111_driver, so drop them and drop
>> the corresponding callbacks from sa1111_bus_type.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> This will conflict with some patches I have - would you like me to queue
> it along with my changes?

Yes, please.

>  When would you like to get this merged?

When possible. :-)

I would like to drop the legacy suspend/resume callbacks from struct
bus_type eventually, as that's long overdue, and this is needed for
that purpose.  Not too urgent, though.

Thanks,
Rafael
