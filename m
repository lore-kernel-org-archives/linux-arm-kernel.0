From: vince@kyllikki.org (Vincent Sanders)
Date: Mon, 13 Sep 2010 17:00:01 +0100
Subject: [PATCH 9/9] Remove unused usb-a9263 default configuration
In-Reply-To: <20100913174349.731a4922@surf>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
	<1284390832-7181-10-git-send-email-vince@kyllikki.org>
	<20100913174349.731a4922@surf>
Message-ID: <20100913160001.GB12197@kyllikki.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 05:43:49PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Mon, 13 Sep 2010 16:13:52 +0100
> Vincent Sanders <vince@kyllikki.org> wrote:
> 
> > The usb-a9263 default configuration has not built throughout the
> > 2.6.36 series (since 2.6.35-git1). The kernel link has failed with
> 
> I'm actually using this config quite regularly on the Calao USB A9263
> board, so I'd prefer to keep this defconfig in the kernel, unless there
> is a more general AT91 defconfig that actually works on this particular
> board.
> 
> > fs/built-in.o: In function `nfs_callback_authenticate':
> > compr_zlib.c:(.text+0x8cf18): undefined reference to `svc_gss_principal'
> 
> Would a patch to fix this prevent this defconfig from being removed ?

Of course, if this defconfig is actually used thats great, but as I
point out it has not been built for the entire release so the
maintainer has obviously not checked.

> 
> Thanks,
> 
> Thomas
> -- 
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Regards Vincent
http://www.kyllikki.org/
