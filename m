From: jason@lakedaemon.net (Jason)
Date: Tue, 6 Mar 2012 09:44:15 -0500
Subject: revert merge commit de68f28 in for-next?
Message-ID: <20120306144415.GR5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

As much as I'd love to see this go in right now, I don't think it's the
correct version (from Mar 2).  This is the merge commit in question:

de68f2847fa759df54e9d8eb0013a0f8ea959c22

It's missing several fixes, #ifdef CONFIG_OF around struct of_device_id,
marvell -> mrvl in compatible properties, etc.

Would you like me to submit a new pull request, or base my fixes off of
this and submit new patches?

Thanks and sorry for the confusion,

Jason.
