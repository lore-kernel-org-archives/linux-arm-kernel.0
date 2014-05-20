From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 May 2014 22:15:07 -0700
Subject: [GIT PULL 1/2] ARM: Keystone SOC updates for 3.16
In-Reply-To: <1399912877-29595-1-git-send-email-santosh.shilimkar@ti.com>
References: <1399912877-29595-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20140520051507.GJ18956@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 12:41:17PM -0400, Santosh Shilimkar wrote:
> Hi Arm-soc folks,
> 
> Please pull below keystone SOC updates for 3.16. It merges cleanly with
> arm-soc 'next/soc' head. As already discussed, the $subject pull request
> has a depedency with DT dma-properties pull request [1] I sent last week
> to be pulled into arm-soc.

Hi,

I didn't see a reply from Russell on that pull request yet, so I haven't
brought it in as a dependency in case he has comments and it needs to be
respun.

If this branch is dependent on that code, then you really need to base it on
top of it, or else you will break bisectability. Essentially you might end up
in a state with bisect where only these patches are applied and not the
dependent ones.


-Olof
