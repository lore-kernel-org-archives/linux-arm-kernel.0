From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 3 Jan 2014 09:21:23 -0200
Subject: [PATCH] ARM: imx: Explicitly pass the active level of the PHY
 reset
In-Reply-To: <20140103041503.GD25079@S2101-09.ap.freescale.net>
References: <1388715253-17206-1-git-send-email-festevam@gmail.com>
 <20140103032230.GC25079@S2101-09.ap.freescale.net>
 <CAOMZO5CZnx9Pi79eufO5uCM7uyvKR6r0VULE9dpwfZBAPpdj7w@mail.gmail.com>
 <20140103041503.GD25079@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5B+veW+kbDL5jS9_=LXBky9Ycs2O=F1KiTU8T0=Z5uOXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 3, 2014 at 2:15 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

>> If this patch goes via your for-next there will be no harm to your
>> tree, since the fec driver will just ignore the gpio flag and the
>> behaviour will be the same as before.
>
> You need to know that my for-next branch target is v3.14-rc not v3.13.

Yes, you are right.

>>
>> If you are not happy with it, then I will have to generate the patch
>> against mainline and ask davem to apply it.
>
> You have to generate a patch against mainline, and we can send it via
> arm-soc tree.

Understood. Will send it soon.

Thanks,

Fabio Estevam
