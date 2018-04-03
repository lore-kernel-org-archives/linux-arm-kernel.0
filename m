From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 3 Apr 2018 20:45:59 +0200
Subject: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
In-Reply-To: <CAKv+Gu_GTmCr8att-_iQ5rD64gvaQC2FJ3cAmYpqRqp_OqPcAg@mail.gmail.com>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180403150139.l7oec4doafmsidfp@ninjato>
 <CAKv+Gu9cqQqq_etTSvdBp4Jjk5O_0FePe74phDqt5EO6Cm-_vQ@mail.gmail.com>
 <20180403181216.f22vtkqrnxjgreuo@ninjato>
 <CAKv+Gu8R19T+9O2tODQeS9vtKANmBXgGcavkRdVRU0NmVtHn2w@mail.gmail.com>
 <20180403183219.htbg3w6mejmysoel@ninjato>
 <CAKv+Gu_GTmCr8att-_iQ5rD64gvaQC2FJ3cAmYpqRqp_OqPcAg@mail.gmail.com>
Message-ID: <20180403184559.z5lixuheqd4ojoti@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> We don't have suspend/resume support yet for this SoC, so I haven't
> been able to try that. Also, the clocks are fixed in this particular
> implementation, so the clk_xxx() calls don't actually do anything.

Then please remove that, too! Good that I asked...

Frankly, not nice to make me review untested code without mentioning
that fact somewhere :(

BTW are you willing to maintain this driver? Then an entry for
MAINTAINERS would be needed.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/e82bfbf3/attachment.sig>
