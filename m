From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 30 Aug 2016 09:08:03 +0300
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAwNS8zM10gZ3BpbzogYWRkIGdlbmVyaWMgc2luZ2xlLXJl?=
 =?UTF-8?B?Z2lzdGVyIGZpeGVkLWRpcmVjdGlvbiBHUElPIGRyaXZlcg==?=
In-Reply-To: <20160829231232.GI1041@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home>
 <20160829231232.GI1041@n2100.armlinux.org.uk>
Message-ID: <1472537283.46556776@f170.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>???????, 30 ??????? 2016, 2:12 +03:00 ?? Russell King - ARM Linux <linux@armlinux.org.uk>:
>
>On Mon, Aug 29, 2016 at 09:39:54PM +0200, Robert Jarzmik wrote:
>> Hi Russell,
>> 
>> Russell King < rmk+kernel@armlinux.org.uk > writes:
>> 
>> > Add a simple, generic, single register fixed-direction GPIO driver.
>> > This is able to support a single register where a fixed number of
>> > bits are used for input and a fixed number of bits used for output.
>> >
>> > Signed-off-by: Russell King < rmk+kernel@armlinux.org.uk >

There is a GPIO driver which already performs these tasks.
Plaease take a look on the gpio-74xx-mmio driver.

---
