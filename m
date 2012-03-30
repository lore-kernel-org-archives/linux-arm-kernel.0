From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 30 Mar 2012 15:50:43 -0700
Subject: error: 'SEGMENT_SIZE' undeclared with arm-eabi-gcc toolchain
Message-ID: <4F7638C3.4060301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Occurs following error with arm-eabi-gcc toolchain (gcc version 4.4.3 -
GCC). But there is no error with arm-none-linux-gnueabi-gcc toolchain
(gcc version 4.4.1 - Sourcery G++ Lite 2009q3)...

fs/binfmt_aout.c: In function 'load_aout_binary':
fs/binfmt_aout.c:255: error: 'SEGMENT_SIZE' undeclared (first use in
this function)
fs/binfmt_aout.c:255: error: (Each undeclared identifier is reported
only once
fs/binfmt_aout.c:255: error: for each function it appears in.)
make[2]: *** [fs/binfmt_aout.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [fs] Error 2

Any idea?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
