From: Valdis.Kletnieks@vt.edu (Valdis.Kletnieks at vt.edu)
Date: Fri, 23 Sep 2011 19:34:21 -0400
Subject: [RFC PATCH 0/3] Add accurate boot timing to a Linux system
In-Reply-To: Your message of "Fri, 23 Sep 2011 16:03:15 PDT."
	<1316818998-30711-1-git-send-email-sjg@chromium.org>
References: <1316818998-30711-1-git-send-email-sjg@chromium.org>
Message-ID: <37959.1316820861@turing-police.cc.vt.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Sep 2011 16:03:15 PDT, Simon Glass said:
> This experimental patch set adds boot timing to a Linux system. The
> timing starts with the boot loader and extends through the kernel into
> user space to the completion of the boot process. The timing starts when
> the system leaves reset, not later when the kernel starts.
> The bootstage record aims to provide 20-30 timestamps ranging from reset
> to login prompt (or some other definition of completion).

Any way to make this play nice with bootchart, which provides much finer
detail records once userspace gets started?

https://github.com/mmeeks/bootchart


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110923/7a4d56f4/attachment.sig>
