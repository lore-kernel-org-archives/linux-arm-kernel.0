From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 01 Aug 2012 17:20:44 -0000
Subject: [RFC 20/22] ARM: keystone: introducing TI Keystone platform
In-Reply-To: <50194E14.4070301@ti.com>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <201207312316.19592.arnd@arndb.de> <50194E14.4070301@ti.com>
Message-ID: <3021860.0mUoOFAv0G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 August 2012 11:41:08 Cyril Chemparathy wrote:
> On 7/31/2012 7:16 PM, Arnd Bergmann wrote:
> > On Tuesday 31 July 2012, Cyril Chemparathy wrote:
> >> Texas Instruments Keystone family of multicore devices now includes an
> >> upcoming slew of Cortex A15 based devices.  This patch adds basic definitions
> >> for a new Keystone sub-architecture in ARM.
> >>
> >> Subsequent patches in this series will extend support to include SMP and take
> >> advantage of the large physical memory addressing capabilities via LPAE.
> >>
> >> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> >> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> >
> 
> Thanks for taking a look, Arnd.
> 
> Any inputs on the other patches in this series?

I briefly looked over them and they largely looked ok, but I'm not really
qualified to comment on most of them.

	Arnd
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120801/69d764d0/attachment-0001.html>
