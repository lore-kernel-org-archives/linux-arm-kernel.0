From: broonie@kernel.org (Mark Brown)
Date: Sun, 12 Jan 2014 19:24:51 +0000
Subject: [PATCH RFC 01/10] ARM: s3c64xx: pm: Use name field of
 generic_pm_domain
In-Reply-To: <52D2E716.8040403@gmail.com>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-2-git-send-email-tomasz.figa@gmail.com>
 <20140112114717.GA31318@amd.pavel.ucw.cz>
 <52D287B1.3090106@gmail.com>
 <20140112185337.GA6810@amd.pavel.ucw.cz>
 <52D2E716.8040403@gmail.com>
Message-ID: <20140112192451.GV29039@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 08:03:50PM +0100, Tomasz Figa wrote:

> Also, there are multiple devices in most domains, so that would
> rather end up being "Domain_I (JPEG, Cam I/F)", "Domain_P (2D, TV
> Enc., Scaler)", "Domain_F (Rot, Post, LCD)".

It's not just that there's multiple devices either, it's also the fact
that the groupings are a bit random and probably more to do with chip
layout or something than function.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140112/9b5f90d9/attachment-0001.sig>
