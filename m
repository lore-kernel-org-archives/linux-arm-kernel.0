From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 21 Dec 2012 12:57:40 +0100
Subject: 3.7 kernel hangs when doing scp
In-Reply-To: <CAOMZO5CdNsFJgYW-DAeS7jEh4r+4RwyvasvJGgfzaeXM3X02bg@mail.gmail.com>
References: <20121218024353.GA17118@kroah.com>
 <CAOMZO5DTB79e3W1_i2NLin7RWXVzraoysEGVLxv9_aoRS39D4Q@mail.gmail.com>
 <20121220043943.GA992@nchen-desktop>
 <CAOMZO5B1DyktHa0Vfb4+-H9bdxaoacas6ZCHEH0bDLuKiCB6hA@mail.gmail.com>
 <CAOMZO5B5hv+oG+8fQYyFxRb=VLOiPmC8+0LhAFLOOzBY4z6PZA@mail.gmail.com>
 <CAOMZO5Dhasq11fyJj73_UcyVdoz-N0MAHBu0=PQUxRn42VOdkw@mail.gmail.com>
 <20121221022249.GA16251@nchen-desktop>
 <CAOMZO5B3EXOB4ijh0LOhvU4g67kdz8KSXw8dvS2dOD1anu_8Bw@mail.gmail.com>
 <20121221114953.GA2678@pengutronix.de>
 <CAOMZO5CdNsFJgYW-DAeS7jEh4r+4RwyvasvJGgfzaeXM3X02bg@mail.gmail.com>
Message-ID: <20121221115740.GB2678@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Only to make the compiler happy. hw_write() is now used by
> ci_role_start(), so I re-ordered so that  hw_write comes first in the
> code and compiler does not complain.

Yup, spotted this on second glance. If you submit the patch, might be
helpful to mention this.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121221/2a121596/attachment.sig>
