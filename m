From: k.raymond@overkiz.com (=?iso-8859-1?Q?K=E9vin?= Raymond)
Date: Wed, 31 Jan 2018 18:04:53 +0100
Subject: Patch submission process about at91 DTS
Message-ID: <20180131170453.GA16869@tp.shaiton.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,

We have several at91-kizbox* DTSs and I have few patches to suggest.
The idea is to split one dts over dtsi + several dts.

My current patches are based an tested over the linux repo[0] against the
master branch (4e19652 Update the RISC-V MAINTAINERS file).

Should I rebase them against the linux-at91[1] repository? Which branch,
at91-next? I would love them to reach the 4.14 branch but am not sure of
the right path to submit those changes.

Thanks for your help,

[0]_git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
[1]_git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git

--
K?vin Raymond
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180131/07360d40/attachment.sig>
