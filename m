From: vb@vsbe.com (vb at vsbe.com)
Date: Tue, 15 Feb 2011 11:26:52 -0800
Subject: compiling 2.6.37 kernel in THUMB2 mode
Message-ID: <AANLkTi=bJwvTMk0B9N5AAbkNXEh_Wmvu75qrdHeL2Rrh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hello all,

I am trying to compile the 2.6.37 kernel in THUMB2 mode and am
experiencing some compilation problems. Some inline assembly in some
files uses commands inappropriate for THUMB2 mode.

I wonder if the kernel is expected to compile cleanly when
CONFIG_THUMB2_KERNEL is enabled (and I am doing something wrong), or
is it know not to compile/work in Thumb2 node for any reason?

Thank you in advance for your help,

Vadim
