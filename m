From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jun 2016 11:04:29 -0700
Subject: What is the Surf board , really?
In-Reply-To: <CACRpkdYtHWObewx6vJXbPU9Wv4rhR0i7sW9YB0Ap8yo5aTJy=Q@mail.gmail.com>
References: <CACRpkdYtHWObewx6vJXbPU9Wv4rhR0i7sW9YB0Ap8yo5aTJy=Q@mail.gmail.com>
Message-ID: <20160602180429.GJ28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02, Linus Walleij wrote:
> I located all my schematics to the APQ8660 DragonBoard thing.
> 
> Now: is the "surf" board one and the same as this? I never really
> got that confirmed. It's got the msm8660 rather than apq8660
> naming and all so I get confused.
> 
> So I was thinking that surf is maybe some other (phone) development
> board.

The surf is an internal development platform that is not the same
as the apq8060 dragonboard. So you're right, they're different.
I'm not aware of any msm8660 dragonboard device in existence, so
it really is an apq8060 chip on there from what I know.

> 
> So before I go patching it around, should I work on this DTS file
> or create a new one for the DragonBoard APQ8660?
> 

I would make a new one that reuses the msm8660.dtsi file and then
does the board specific things.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
