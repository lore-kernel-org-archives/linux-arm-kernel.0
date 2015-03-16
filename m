From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 16 Mar 2015 11:52:42 +0000
Subject: pl330 endian fix and two fixups
Message-ID: <1426506765-10085-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When getting the pl330 driver to work on an Xilinx Zynq working in
big-endian the first patch is needed to get the dmatest suite to
pass.

The second and third patches are warning fixes from sparse, of
which the third may not be the complete solution. It works for me.
