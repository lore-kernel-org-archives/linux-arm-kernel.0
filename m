From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 26 Oct 2012 17:54:00 +0000 (UTC)
Subject: [PATCH 2/5] drivers: usb: otg: make twl6030_usb as a comparator
 driver to omap_usb2
In-Reply-To: <508AAA85.6070905@ti.com>
References: <1346943430-18236-1-git-send-email-kishon@ti.com>
 <1346943430-18236-3-git-send-email-kishon@ti.com>
 <CAH+eYFAj1ecvmiJCu8QDCr3LjHT5eXjq6zsZMiVRPROoWcDuNQ@mail.gmail.com>
 <CAAe_U6K1RXA3b5u9WvE=2VoXym9Vj3KM7c0J27jKz+2KrV4tsg@mail.gmail.com>
 <CAH+eYFAhVE8cAte2PFk3jinV9n3m+eDLtE43QxzRXMScnFGcrA@mail.gmail.com>
 <508AA94B.10504@ti.com> <508AAA85.6070905@ti.com>
Message-ID: <alpine.DEB.2.00.1210261750430.7573@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Oct 2012, Benoit Cousson wrote:

> On 10/26/2012 05:16 PM, Roger Quadros wrote:
> 
> > I still can't get musb to work on 3.7-rc2. Apparently it is still
> > missing the patches from Benoit's for_3.7/dts_part2.
> > 
> > Maybe I just need to wait for it to be merged?
> 
> They are now in a for_3.8/dts. Unfortunately, one patch that was adding
> ctrl_module address in the USB data was rejected and thus I'm not sure
> it will work without that.

For v3.7-rc timeframe, looks like it's waiting on an ack from you:

http://www.spinics.net/lists/arm-kernel/msg201028.html


- Paul
