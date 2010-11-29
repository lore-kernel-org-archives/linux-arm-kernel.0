From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 29 Nov 2010 13:12:50 -0800
Subject: [GIT PULL] Kconfig changes for MSM to enable SMP
In-Reply-To: <1290531015.4165.19.camel@m0nster>
References: <1290531015.4165.19.camel@m0nster>
Message-ID: <1291065170.30902.22.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-11-23 at 08:50 -0800, Daniel Walker wrote:
> Russell,
> 
> I've been trying to get these in for a while now. They're just Kconfig
> changes that allow MSM to use SMP. One of the patch does have a slight
> clean up where it moves the "\" out one space under "config SMP". I
> think that was the product of some feedback I received.
> 
> Please pull, or let me know if you want them done differently.

Could you give me some feedback on why your not pulling this? I need
these changes to go in in order to add SMP support, which I have planned
to add this coming merge window.

Do you want these going into you patch system? Do you not like the lack
of TWD and SCU support or the way I accomplished the removal of them?

Gimme some hints please ..

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
