From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 13 Sep 2010 17:43:49 +0200
Subject: [PATCH 9/9] Remove unused usb-a9263 default configuration
In-Reply-To: <1284390832-7181-10-git-send-email-vince@kyllikki.org>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
	<1284390832-7181-10-git-send-email-vince@kyllikki.org>
Message-ID: <20100913174349.731a4922@surf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 13 Sep 2010 16:13:52 +0100
Vincent Sanders <vince@kyllikki.org> wrote:

> The usb-a9263 default configuration has not built throughout the
> 2.6.36 series (since 2.6.35-git1). The kernel link has failed with

I'm actually using this config quite regularly on the Calao USB A9263
board, so I'd prefer to keep this defconfig in the kernel, unless there
is a more general AT91 defconfig that actually works on this particular
board.

> fs/built-in.o: In function `nfs_callback_authenticate':
> compr_zlib.c:(.text+0x8cf18): undefined reference to `svc_gss_principal'

Would a patch to fix this prevent this defconfig from being removed ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
