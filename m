From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Sep 2010 19:24:43 +0100
Subject: [PATCH 9/9] Remove unused usb-a9263 default configuration
In-Reply-To: <AANLkTimowGP9jiMayR3QLAnesmHGZJWL=WdTZOppRdeY@mail.gmail.com>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
	<1284390832-7181-10-git-send-email-vince@kyllikki.org>
	<AANLkTimowGP9jiMayR3QLAnesmHGZJWL=WdTZOppRdeY@mail.gmail.com>
Message-ID: <20100913182443.GB3819@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 08:08:32PM +0200, avictor.za at gmail.com wrote:
> hi,
> 
> > fs/built-in.o: In function `nfs_callback_authenticate':
> > compr_zlib.c:(.text+0x8cf18): undefined reference to `svc_gss_principal'
> 
> That error would seem to imply that NFS support is broken, broken on
> ARM, or the KConfig dependencies for NFS are not correct?

The question is: why has no one noticed and/or complained to the NFS
people about this - or if they have, can they speak up soon?

If nothing has happened, then Vince is quite correct - if a defconfig
has failed to build for a while and no one has noticed, that's because
it isn't being used.  If it isn't being used, it can be removed.
