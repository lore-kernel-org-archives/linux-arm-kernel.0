From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 27 Apr 2012 08:32:10 +0200
Subject: [PATCH v2] Convert i.MX architecture to generic clock framework
In-Reply-To: <20120427022851.GC2234@S2101-09.ap.freescale.net>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <4F995657.4080505@de.bosch.com>
 <20120427022851.GC2234@S2101-09.ap.freescale.net>
Message-ID: <4F9A3D6A.5040506@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.04.2012 04:28, Shawn Guo wrote:
> On Thu, Apr 26, 2012 at 04:06:15PM +0200, Dirk Behme wrote:
>>> git://git.pengutronix.de/git/imx/linux-2.6.git work/v3.4-rc4-imx-clk
>> Booting this on top of a 3.4-rc4 on a i.MX6 SabreLite gives me
>>
> What do you mean "on top of a 3.4-rc4"?  Sascha's branch is built up
> on v3.4-rc4.
> 
>> ..
>> Linux video capture interface: v2.00
>> Switching to clocksource mxc_timer1
>> Clockevents: could not switch to one-shot mode:
>> Clockevents: could not switch to one-shot mode:
>> Clockevents: could not switch to one-shot mode: dummy_timer is not
>> functional.
>>  dummy_timer is not functional.
>> Clockevents: could not switch to one-shot mode:
>> Could not switch to high resolution mode on CPU 0
>>  dummy_timer is not functional.
>> Could not switch to high resolution mode on CPU 2
>> Could not switch to high resolution mode on CPU 1
>>  dummy_timer is not functional.
>> Could not switch to high resolution mode on CPU 3
>> NET: Registered protocol family 2
>> ...
>>
>> I'm no expert of this, so just in case this is interesting for somebody.
>>
> I just booted my sabrelite board using Sascha's branch and can not
> reproduce it.

Sacha, Shawn, many thanks for your help! I can't reproduce it today 
morning, too :( I will recheck again.

Many thanks again and best regards

Dirk
