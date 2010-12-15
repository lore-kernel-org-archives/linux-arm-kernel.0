From: smuckle@codeaurora.org (Steve Muckle)
Date: Wed, 15 Dec 2010 09:42:14 -0800
Subject: [PATCH v5 5/5] msm: add SMP support for msm
In-Reply-To: <20101215160323.GA9937@n2100.arm.linux.org.uk>
References: <1292302233-16194-1-git-send-email-johlstei@codeaurora.org>
	<1292302233-16194-6-git-send-email-johlstei@codeaurora.org>
	<AANLkTimnuTcv+5cWNzvV-Z=1LHsAmTojDSBJMjjOs7K+@mail.gmail.com>
	<20101215134414.GA8682@huya.qualcomm.com>
	<20101215160323.GA9937@n2100.arm.linux.org.uk>
Message-ID: <4D08FDF6.3040403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 12/15/10 08:03, Russell King - ARM Linux wrote:
> As far as hotplug code goes, I wish folk would see what their hardware
> can actually do with the secondary CPUs - can they take the CPU fully
> offline and into a proper dormant state, and when they reawaken it, can
> they wake it in the same manner as the CPU is brought online during
> boot.

This is possible with MSM8660 and we have this working internally, but
it relies on a fair amount of power management code that is not ready to
be sent out yet. This hotplug support is just meant as a starting point
while getting the core MSM8660 support in.

thanks,
Steve

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
