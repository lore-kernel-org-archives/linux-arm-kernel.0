From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Mon, 13 Sep 2010 20:08:32 +0200
Subject: [PATCH 9/9] Remove unused usb-a9263 default configuration
In-Reply-To: <1284390832-7181-10-git-send-email-vince@kyllikki.org>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
	<1284390832-7181-10-git-send-email-vince@kyllikki.org>
Message-ID: <AANLkTimowGP9jiMayR3QLAnesmHGZJWL=WdTZOppRdeY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> fs/built-in.o: In function `nfs_callback_authenticate':
> compr_zlib.c:(.text+0x8cf18): undefined reference to `svc_gss_principal'

That error would seem to imply that NFS support is broken, broken on
ARM, or the KConfig dependencies for NFS are not correct?


Regards,
  Andrew Victor
