From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 28 Feb 2014 22:24:12 +0100
Subject: ccf: where to put constraints?
In-Reply-To: <8e8ce023-b9a4-41a5-b06c-0f6d934f22e6@VA3EHSMHS020.ehs.local>
References: <20140224201046.GA13155@katana>
 <8e8ce023-b9a4-41a5-b06c-0f6d934f22e6@VA3EHSMHS020.ehs.local>
Message-ID: <20140228212412.GD2517@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

> I.e. when a clock consumer needs to be notified about its input clock
> being changed it registers a clock notifier.

I found the notifiers, too, but I am still not sure they are proper for
my case. There, CPU and GPU clocks are siblings, there is no
parent-child relationship.

Anyhow, I have been told cpufreq is not needed currently, so this task
is postponed. Thanks for the input nonetheless!

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/6738af04/attachment.sig>
