From: dianders@chromium.org (Doug Anderson)
Date: Wed, 13 Mar 2013 08:14:24 -0700
Subject: [PATCH v3 2/3] ARM: dts: Add i2c-arbitrator bus for
 exynos5250-snow
In-Reply-To: <096801ce1fbc$979d1550$c6d73ff0$%kim@samsung.com>
References: <1360887677-20758-1-git-send-email-dianders@chromium.org>
 <1360957573-864-1-git-send-email-dianders@chromium.org>
 <1360957573-864-2-git-send-email-dianders@chromium.org>
 <CAHfPSqAtxjYV79VvQZDLtzfyRxkYoMEc4=S2fN=KRNtYOEQ7ig@mail.gmail.com>
 <096801ce1fbc$979d1550$c6d73ff0$%kim@samsung.com>
Message-ID: <CAD=FV=Wx0HTMUt8ZPiK3HQQDQkN=sNd=-XUZFJaDvcE2bVBTxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Wed, Mar 13, 2013 at 12:30 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> BTW, Doug, I think, this should be re-worked to use pinctrl. Can you?

Yes, I've already got this locally.  I hadn't sent it up yet since I
wasn't sure whether pinctrl would land before or after this.  I'll
send it up today against my local cherry-pick of Thomas's pinctrl
stuff (since it doesn't seem to be in linux-next nor in
arm-soc/for-next).

Naveen: I'm going to keep your Tested-by on all 3 patches if that's
OK.  The only difference will be the gpio specifier in the device tree
and the change is trivial.

-Doug
