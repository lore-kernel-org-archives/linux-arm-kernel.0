From: davidb@codeaurora.org (David Brown)
Date: Wed, 8 Dec 2010 09:24:23 -0800
Subject: [PATCH RFC] arm: Add argument to init_machine
In-Reply-To: <20101208140722.GD9777@n2100.arm.linux.org.uk>
References: <1291768976-7773-1-git-send-email-davidb@codeaurora.org>
	<20101208140722.GD9777@n2100.arm.linux.org.uk>
Message-ID: <20101208172423.GA18569@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 02:07:22PM +0000, Russell King - ARM Linux wrote:

> As far as the patch itself goes, it looks fine, but I'm not seeing
> anything using this new facility in this patch.
> 
> I don't like adding things without seeing how they're going to be
> used, as sometimes these things never get used.  Maybe you can give
> some examples?

We've got some new board files that can make use of it.  I'll work on
getting those to a point where I can send them out.  I mostly just
wanted to make sure that the idea didn't cause excessive revulsion.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
