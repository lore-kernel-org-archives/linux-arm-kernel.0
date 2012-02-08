From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 8 Feb 2012 12:16:43 +0100
Subject: [PATCH v2 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <20120208090055.GP3852@pengutronix.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
 <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
 <4F31AB63.3020301@gmail.com>
 <20120208081508.GA6673@avionic-0098.mockup.avionic-design.de>
 <20120208090055.GP3852@pengutronix.de>
Message-ID: <20120208111643.GC17615@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sascha Hauer wrote:
> I have a series porting all in kernel drivers to this framework. I can
> follow up on this series once it's clear we want to go this way. With
> this series the way will be free to move to a better pwm matching
> without a global pwm index because the drivers won't be affected by
> this change anymore.

Nice. I already ported the PXA and Blackfin drivers in this series and was
planning to port more in subsequent versions but if you've already done most
of the work I can just skip. I should probably keep the Tegra driver in the
series because it doesn't exist in the kernel tree yet.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120208/e59e2c18/attachment.sig>
