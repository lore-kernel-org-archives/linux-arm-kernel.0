From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 24 Feb 2014 21:10:46 +0100
Subject: ccf: where to put constraints?
Message-ID: <20140224201046.GA13155@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Where do I put constraints when using the CCF? I have a CPU and GPU
clock derived from the same PLL. Both clocks have their own divider.
Now, there is the additional constraint that the CPU clock must not be
lower than the GPU clock. Do I add checks in the set_rate functions?
Feels like the wrong layer, but not checking it and blindly relying on
somebody else does not feel correct, too. How to do it best?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140224/905abefb/attachment.sig>
