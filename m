From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 27 May 2010 17:58:30 +0300
Subject: [PATCH] rtc-s3c: Fix rtc-s3c driver initialization
In-Reply-To: <1274971709-7874-1-git-send-email-anarsoul@gmail.com>
References: <1274971709-7874-1-git-send-email-anarsoul@gmail.com>
Message-ID: <201005271758.37866.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 27 ??? 2010 17:48:29 ????? Vasily Khoruzhick ???????:
> setfreq should be called only after rtc device registration,
> as it uses rtc device; s3c_rtc_cpu_type should be checked
> only once it was set.

Discard this patch, max_user_freq is still set after first setfreq call.
Will resend fixed version soon.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100527/99e46476/attachment.sig>
