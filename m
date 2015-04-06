From: mwp@mwp.id.au (Mark Williams)
Date: Tue, 7 Apr 2015 01:25:33 +0930
Subject: imx/mxs dcp memcpy access?
Message-ID: <CA+OkyLRBAEgC6pBVP6Ay008eU05DW7jZzV=5af-EEyqx6NEa0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings all,

First, my apologies is this isn't the correct place to be asking this.

I'm developing software running on a iMX28 SoC.
At the moment large'ish memcpy's are using up a decent amount of processor time.

Ive noticed in the "i.MX28 Applications Processor Reference Manual"
that the iMX28's DCP provides a memcpy function.
It appears this is used in some way by the mxs crypto functions in the kernel.
Is there any way i can gain access/use the dcp memcpy from userspace?

Thanks in advance,
Mark Williams.
