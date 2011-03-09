From: r.sricharan@ti.com (Sricharan R)
Date: Wed, 9 Mar 2011 17:19:58 +0530
Subject: [PATCH] omap2+: mux: Remove the use of IDLE flag.
In-Reply-To: 3454d5fcdc4f7fb8e8a5bcaffca95112@mail.gmail.com
References: <1299472552-22017-1-git-send-email-r.sricharan@ti.com>
	<20110308164033.GC26463@atomide.com>
	3454d5fcdc4f7fb8e8a5bcaffca95112@mail.gmail.com
Message-ID: <b76e32aff88265d31cc1b7b2fc502a32@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
>-----Original Message-----
>From: Sricharan R [mailto:r.sricharan at ti.com]
>Sent: Wednesday, March 09, 2011 1:19 PM
>To: 'Tony Lindgren'
>Cc: 'linux-omap at vger.kernel.org'; Benoit Cousson; Santosh Shilimkar;
>'paul at pswan.com'; 'linux-arm-kernel at lists.infradead.org'
>Subject: RE: [PATCH] omap2+: mux: Remove the use of IDLE flag.
>
[....]

>>* sricharan <r.sricharan@ti.com> [110306 20:33]:
>>> Currently OMAP_DEVICE_PAD_IDLE flag is used to mux pins
>>> dynamically. This can be simplified by using the enabled
>>> state variable of each pad. This also fixes the issue of
>>> the static pads not getting muxed after idling and
>>> disable/enable state transitions.
>>
>>Looks good, can you please repost one more time with linux-arm-kernel
>>mailing list also Cc'd?
>>
>Ok sure. I have  re posted  this to the linux-arm-kernel list.


Btw,I have fixed the comments on the below patches that
I sent for configuring the serial pads.

4430sdp:
http://marc.info/?l=linux-omap&m=129900334420003&w=2

omap4panda:
http://marc.info/?l=linux-omap&m=129900338520082&w=2

3430sdp:
http://marc.info/?l=linux-omap&m=129619117726479&w=2

Can you please check if they are ok?

Thanks,
 Sricharan
