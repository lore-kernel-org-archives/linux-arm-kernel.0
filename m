From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2018 14:28:17 +0200
Subject: [PATCH v4] pinctrl: msm: fix gpio-hog related boot issues
In-Reply-To: <CACRpkdZPEHvnQdwh5Uu5kwqK7yVGTaw_cZR+GOzsG9pg4oEktA@mail.gmail.com>
References: <20180412190138.12372-1-chunkeey@gmail.com>
 <CACRpkdZPEHvnQdwh5Uu5kwqK7yVGTaw_cZR+GOzsG9pg4oEktA@mail.gmail.com>
Message-ID: <CACRpkdbND_LWJmoH9yPQ2ruorM8CRWVk2S0nd1GCChZ=fuz_Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 2:03 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Apr 12, 2018 at 9:01 PM, Christian Lamparter <chunkeey@gmail.com> wrote:
>
>> Sven Eckelmann reported an issue with the current IPQ4019 pinctrl.
>> Setting up any gpio-hog in the device-tree for his device would
>> "kill the bootup completely":
(...)
>> Reported-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>
> This patch looks VERY good to me.
>
> I am fine in merging it into pin control including the ranges
> fixes.
>
> I need Andy's and Bjorn's ACKs on it though!
>
> Can you guys provide that?

Hm? Andy, Bjorn?

Seems you guys are a bit snowed under.

I guess I have to just apply it at some point and see what
happens...

Yours,
Linus Walleij
