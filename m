From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 May 2011 10:37:40 +0200
Subject: is there the sample for how to use the tcm on userspace ?
In-Reply-To: <BANLkTi=aDBjBsAx0XwL1HRKCnO1=2wHaVA@mail.gmail.com>
References: <BANLkTi=_1cXiQ6A6fCmfywyHHAOvB3DQpA@mail.gmail.com>	<4DE4A2AF.2040708@stericsson.com>
	<BANLkTi=aDBjBsAx0XwL1HRKCnO1=2wHaVA@mail.gmail.com>
Message-ID: <4DE4A8D4.2090208@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2011 10:35 AM, Jello huang wrote:
> HI linus,some critical code(for solve the real time problem)  need to 
> use itcm and dtcm from userspace.So i need design the interface to the 
> userspace app

Hm OK that seems like a good reason to have it available.

But I have no good suggestion of a suitable userspace interface :-(

Maybe the mailing list have some examples of how to use on-chip
memory like SRAM or TCM from userspace?

Linus Walleij
