From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Sep 2015 11:44:31 +0200
Subject: [PATCH 3/4] input: Add new sun4i-keypad driver
In-Reply-To: <CAJzetvvUscEgTQ0Sr-BF7D6rzN_bfWT1KikRqz+BvSV-2+TWrw@mail.gmail.com>
References: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
 <1442325957-10102-4-git-send-email-yassinjaffer@gmail.com>
 <20150917130520.GD4684@lukather>
 <CAJzetvvUscEgTQ0Sr-BF7D6rzN_bfWT1KikRqz+BvSV-2+TWrw@mail.gmail.com>
Message-ID: <20150918094431.GN4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yassin,

On Fri, Sep 18, 2015 at 10:19:55AM +1000, Yassin Jaffer wrote:
> Hi Maxime
> 
> I appreciate your time and efforts .
> 
> Do you need that rate to be enforced, or is it some leftover from the
> > allwinner BSP?
> 
> 
> I've found that clock rate works fine with the default denounce and scan
> cycle.

It was not really my point. My point was do you *need* it to operate.

And so your properties were in clock cycles?

Please use a unit indenpendant of the clock rate, like seconds or Hz
(or any multiple of them).

> By the way do you have any dev board which expose the keypad pins?

I don't think I have any.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150918/242b3918/attachment.sig>
