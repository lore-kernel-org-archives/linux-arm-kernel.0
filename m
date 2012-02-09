From: davidb@codeaurora.org (David Brown)
Date: Thu, 9 Feb 2012 10:04:11 -0800
Subject: hex number case in dts files.
Message-ID: <20120209180411.GA5654@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've noticed an inconsistency in the case of letters in hex constants
in various dts files.  The ones that are actually numbers probably
don't really matter, the but the node names are case sensitive
strings, and in some sense do matter.

I ask because some people I've spoken with internally seem to have
strong opinions about what case hex constants should be, and it'd be
nice to be able to have some guideline about this.  Historically, I've
always seen DT hex values in lowercase.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
