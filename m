From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 19 Feb 2014 12:59:03 +0000
Subject: [PATCH v5 4/5] ARM: Kirkwood: Fix qnap vendor prefix
In-Reply-To: <1392814154-11284-5-git-send-email-klightspeed@killerwolves.net>
References: <1392814154-11284-1-git-send-email-klightspeed@killerwolves.net>
 <1392814154-11284-5-git-send-email-klightspeed@killerwolves.net>
Message-ID: <1392814743.9366.306.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-02-19 at 22:49 +1000, klightspeed at killerwolves.net wrote:
> Correct the vendor prefix for qnap, which should be the stock ticker
> symbol qnapsz.

No. This is an ABI change which appears to be gratuitous.

Perhaps it's really necessary, and perhaps it's harmless because it
won't *really* break compatibility with existing firmware because these
boxes have *always* shipped with a DTB built into the kernel or
something.

In which case all I'm complaining about is the fact that you didn't
properly address that in the commit comment and *explain* why it was
OK...

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/cb468199/attachment.bin>
