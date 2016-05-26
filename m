From: labath@google.com (Pavel Labath)
Date: Thu, 26 May 2016 17:04:46 +0100
Subject: Support for unaligned watchpoints in arm/arm64
Message-ID: <CAJt8pk8FBbTVMMM45SaEs86MZOp0o6xChAsMT1sO+_Xy-GENyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I've been wondering if there are any plans about adding support for
unaligned watchpoints to the kernel. It seems quite a shame that
applications are not able not use them, even though the hardware
should support that feature.

I've filed a feature request at
<https://bugzilla.kernel.org/show_bug.cgi?id=117621> with a bit more
details about the issue.

cheers,
pl
