From: emilgoode@gmail.com (Emil Goode)
Date: Sat, 24 May 2014 17:22:00 +0200
Subject: [PATCH] ARM: imx: introduce function imx_free_mx3_camera
In-Reply-To: <20140522181024.GA20155@pengutronix.de>
References: <1400781080-6117-1-git-send-email-emilgoode@gmail.com>
 <20140522181024.GA20155@pengutronix.de>
Message-ID: <20140524152200.GA4666@lianli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Uwe and Greg,

> You'd do a better deed if you picked up
> http://thread.gmane.org/gmane.linux.kernel/1613364/focus=1635995

Since there is nothing wrong with the last version of the patch in
the above thread, I feel strange about picking it up and just splitting
it into two patches. However it would be good to have it applied.

I think the reason why the author didn't resend is that the object file
and data structure layout information in the changelog depend on the
changes to both .name and .dma_mask and by splitting the patch this
information would not apply to any one of the resulting two patches.

Perhaps keeping this information in the changelog is a good reason for
applying the patch as it is?

(I have attached the patch in question)

Best regards,

Emil Goode
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-driver-core-platform-don-t-leak-memory-allocated-for.patch
Type: text/x-diff
Size: 9958 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140524/e1732228/attachment-0001.bin>
