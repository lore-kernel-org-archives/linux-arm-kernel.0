From: davidb@codeaurora.org (David Brown)
Date: Mon, 24 Jan 2011 23:49:21 -0800
Subject: questions about arm trustzone
In-Reply-To: <AANLkTi=eCOiP7MrUSG4WRMN0kj_+ZWvZ=z7VYDfkshU_@mail.gmail.com>
	(sen wang's message of "Tue, 25 Jan 2011 10:15:14 +0800")
References: <AANLkTi=eCOiP7MrUSG4WRMN0kj_+ZWvZ=z7VYDfkshU_@mail.gmail.com>
Message-ID: <8yad3nlh18e.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24 2011, sen wang wrote:

> we need to build a little os in the secure mode,and run linux in the
> normal world.but, can I use gcc to compile the special instructions like 'smc'.
> which gcc version can work? and where can i find the example code
> switching between the secure and normal worlds?

In the 2.6.38-rc2 kernel, arch/arm/mach-msm/scm.c does this.  I don't
think there is any other code in the kernel, yet.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
