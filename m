From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 5 Oct 2017 23:41:10 -0500
Subject: [PATCH 2/2] arm64: dts: qcom: Rename SBC to DragonBoard 410c
In-Reply-To: <3241c0f0-cc40-0262-a771-a0b6fd020b54@suse.de>
References: <20171003091155.7138-1-linus.walleij@linaro.org>
 <20171003091155.7138-2-linus.walleij@linaro.org>
 <b6b065c7-ad6b-d3da-704f-f139f12752d8@linaro.org>
 <CAF6AEGta20EGJOvLcFWVfUa3kpfq+Udyp1QRNzjY8P290A2tVg@mail.gmail.com>
 <CAP71Wjy2gEn=sGz5kN++=TdZ4S1cmE-3fdw-5__tdtR-M9RDGQ@mail.gmail.com>
 <CAF6AEGvRB_SGQ_Xv33FiPZRyp+Wf29aG_Ex6rVk2Czov-Gjj9Q@mail.gmail.com>
 <CAF6AEGvtfAYx5mgg9mMVeXdO5mStD9gJvi5+Pp46jYj-e8WnOQ@mail.gmail.com>
 <CAAqcGH=aZSg7Dzv_Y2erUxmCaN7LXYqxgO9wnPKqSVX1fBuCMg@mail.gmail.com>
 <3241c0f0-cc40-0262-a771-a0b6fd020b54@suse.de>
Message-ID: <20171006044110.GA3105@hector>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 03:06:34PM +0200, Alexander Graf wrote:

<snip>

> You could also simply carry around both, with for example the dragonboard
> one including sbc and overriding the machine name.
> 
> But please don't remove any device tree file names that were there before.
> It only causes confusion for everyone.

This seems to be a reasonable solution.


Regards,
Andy
