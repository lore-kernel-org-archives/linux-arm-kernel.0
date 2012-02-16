From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Feb 2012 20:39:39 +0100
Subject: [PATCH] serial/sirf: fixup for changes to pin control
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1790EC8791@HQMAIL01.nvidia.com>
References: <1329417828-6005-1-git-send-email-linus.walleij@linaro.org>
 <74CDBE0F657A3D45AFBB94109FB122FF1790EC8791@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdavPdK13cJ-mdDXwbz3jNCSCzaa8LTdMDXOy4mi+pmdmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 8:01 PM, Stephen Warren <swarren@nvidia.com> wrote:

> Should this patch be put into the pinctrl tree since that's where the
> API changed, perhaps even squashed into the original commit to avoid
> git bisect breakage, unless your branch needs to be stable?

Hm yeah I will for sure put it into the pinctrl tree.
The Sirf doesn't even have a defconfig so it was just my memory of
the Sirf that got me to remember it. I might squash if I don't get any
comments on this patch.

> Otherwise,
> this change will conflict with my future similar change if pulled for
> the same kernel version.

It'll be in linux-next tomorrow or so.

Yours,
Linus Walleij
