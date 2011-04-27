From: davidb@codeaurora.org (David Brown)
Date: Wed, 27 Apr 2011 10:36:06 -0700
Subject: [PATCH V2 2/2] mtd: msm_nand: Add initial msm nand driver support.
In-Reply-To: <4DB83E70.4050402@codeaurora.org> (Murali Nalajala's message of
	"Wed, 27 Apr 2011 21:34:00 +0530")
References: <1302938249-4601-1-git-send-email-mnalajal@codeaurora.org>
	<4DABE8FE.5040300@parrot.com> <4DB6C13F.2020402@codeaurora.org>
	<4DB80E2A.4000203@parrot.com> <4DB83E70.4050402@codeaurora.org>
Message-ID: <8yapqo74mwp.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27 2011, Murali Nalajala wrote:

> We have used nand base kind of implementation wherever is possible.
> eg: We have leveraged the code from nand base to detect the nand
> device properties.

Basing code off of other code but with modification is very different
than using that other code.  Copying and modifying creates more code
that can miss fixes and other changes.

I do think there is value in working with the nand code.  Remember that
the nand code is not immutable.  If there is something that almost does
what msm_nand needs, perhaps is can be changed to support that as well.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
