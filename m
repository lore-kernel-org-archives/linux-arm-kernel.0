From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 19 Jun 2013 11:57:50 +0100
Subject: No subject
Message-ID: <1371639471-14144-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I found this one whilst testing versatile-express with a -rc kernel
and was considering if this is the correct way to fix this.

[PATCH] atags_to_fdt: take into account root's #size and #cells
