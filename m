From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 29 Jan 2014 13:52:39 -0800
Subject: imx6 wand board lockdep warnings on boot
Message-ID: <CAGa+x84Oko25r+xE_Z3wrY_dVCrMcF5AKvbBBMcbyvAMTOSoqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For awhile now, the wand boards have had some noisy lockdep warnings
during boot, but I'm not sure if anyone is looking into them.  I see
it on the wand-solo and wand-quad, but not the dual.  Full boot logs
for all three are attached from v3.13.

Kevin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: wand-solo.log.gz
Type: application/x-gzip
Size: 9222 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140129/1d56745f/attachment-0003.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: wand-dual.log.gz
Type: application/x-gzip
Size: 5971 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140129/1d56745f/attachment-0004.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: wand-quad.log.gz
Type: application/x-gzip
Size: 9409 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140129/1d56745f/attachment-0005.bin>
