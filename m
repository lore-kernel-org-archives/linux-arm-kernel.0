From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2012 16:04:53 +0000
Subject: revert merge commit de68f28 in for-next?
In-Reply-To: <20120306144415.GR5050@titan.lakedaemon.net>
References: <20120306144415.GR5050@titan.lakedaemon.net>
Message-ID: <201203061604.53412.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 March 2012, Jason wrote:
> As much as I'd love to see this go in right now, I don't think it's the
> correct version (from Mar 2).  This is the merge commit in question:
> 
> de68f2847fa759df54e9d8eb0013a0f8ea959c22
> 
> It's missing several fixes, #ifdef CONFIG_OF around struct of_device_id,
> marvell -> mrvl in compatible properties, etc.
> 
> Would you like me to submit a new pull request, or base my fixes off of
> this and submit new patches?
> 
> Thanks and sorry for the confusion,
> 

I've marked that branch a 'staging/' branch, which means that it's not
intended for being sent to Linus. Please send a replacement branch instead.

Once something is merged into a next/* branch instead of staging/*, you
should send further patches on top.

	Arnd
