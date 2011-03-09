From: r.sricharan@ti.com (Sricharan R)
Date: Wed, 9 Mar 2011 13:19:27 +0530
Subject: [PATCH] omap2+: mux: Remove the use of IDLE flag.
In-Reply-To: <20110308164033.GC26463@atomide.com>
References: <1299472552-22017-1-git-send-email-r.sricharan@ti.com>
	<20110308164033.GC26463@atomide.com>
Message-ID: <3454d5fcdc4f7fb8e8a5bcaffca95112@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
>-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>owner at vger.kernel.org] On Behalf Of Tony Lindgren
>Sent: Tuesday, March 08, 2011 10:11 PM
>To: sricharan
>Cc: linux-omap at vger.kernel.org; b-cousson at ti.com;
santosh.shilimkar at ti.com;
>paul at pswan.com
>Subject: Re: [PATCH] omap2+: mux: Remove the use of IDLE flag.
>
>* sricharan <r.sricharan@ti.com> [110306 20:33]:
>> Currently OMAP_DEVICE_PAD_IDLE flag is used to mux pins
>> dynamically. This can be simplified by using the enabled
>> state variable of each pad. This also fixes the issue of
>> the static pads not getting muxed after idling and
>> disable/enable state transitions.
>
>Looks good, can you please repost one more time with linux-arm-kernel
>mailing list also Cc'd?
>
Ok sure. I have  re posted  this to the linux-arm-kernel list.
>Thanks,
>
>Tony
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo at vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
