From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Mon, 4 Nov 2013 09:43:20 +0100
Subject: [PATCH v7 0/5] clk: clock deregistration support
In-Reply-To: <5273D9CD.2010800@gmail.com>
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com>
 <CACmBeS2TiiTJ_n0bEzXGKN8B=U9EKXeVtrE2q0jgxsxf5TBivw@mail.gmail.com>
 <5273D9CD.2010800@gmail.com>
Message-ID: <CACmBeS3DhHnQR7Ze8oZVAC9HThmXR4n7f90yje+R=8uRq9Nvsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 November 2013 17:41, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:
> It is recommended to quote also human readable patch summary line,
> so it's more immediately clear which patch you refer to.

Sorry about that. This was tested on a clean (some added moxart
drivers but no other patches) next-20131031, reverting the following
patch:
"clkdev: Fix race condition in clock lookup from device tree" -
0b35b92fb3600a2f9ca114a6142db95f760d55f5

> Is the warning still triggered when you apply this patch:
> http://www.spinics.net/lists/arm-kernel/msg283550.html
> onto next-20131031 instead of reverting ?

After patch, the warning is no longer triggered.

Thanks,
Jonas
