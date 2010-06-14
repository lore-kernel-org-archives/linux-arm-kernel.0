From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 14 Jun 2010 09:04:11 +0300
Subject: [PATCH v2] rtc-s3c: Fix rtc-s3c driver initialization
In-Reply-To: <1274975846-14006-1-git-send-email-anarsoul@gmail.com>
References: <1274975846-14006-1-git-send-email-anarsoul@gmail.com>
Message-ID: <201006140904.17950.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 27 ??? 2010 18:57:26 ????? Vasily Khoruzhick ???????:
> setfreq should be called only after rtc device registration,
> as it uses rtc device; s3c_rtc_cpu_type should be checked
> only once it was set.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Hi, Ben.

What about this patch? I've seen similar series on linux-samsung-soc maillist, 
but neither their series nor my patch is applied to your tree. Why? :)

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100614/3c8e6704/attachment.sig>
