From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 4 Apr 2012 14:23:35 +0200
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <CAMiH66EC7=x0sRYhE3hpEyBemDGSRS19xguQUqKj2kuPw5Tifw@mail.gmail.com>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <1332368519-22660-2-git-send-email-w.sang@pengutronix.de>
 <CAMiH66EC7=x0sRYhE3hpEyBemDGSRS19xguQUqKj2kuPw5Tifw@mail.gmail.com>
Message-ID: <20120404122335.GD17187@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Could you provide an API such as gpmi_reset_block()?
> It will much helpful to me.

Ah, that's what you meant in the other thread. Well, this can be added
later. My suggestion

1) get this mainline to remove mach dependencies
2) convert the drivers
3) do proper timeout mechanisms
4) add features

where 2-4 can probably happen more or less simultaneously.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120404/564fdad5/attachment.sig>
