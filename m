From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 21 Jan 2015 08:47:20 +0530
Subject: [PATCHv3 2/8] devfreq: exynos: Add documentation for generic
 exynos memory bus frequency driver
In-Reply-To: <54BE3E10.2080906@samsung.com>
References: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
 <1420681257-3078-3-git-send-email-cw00.choi@samsung.com>
 <CAL_Jsq+5sdsm_-VW-ta+qV-NBao-XTHvsYWcbMdZmbP0Nw43Cw@mail.gmail.com>
 <CAKohpomqosqxeDANC=NLBVmOUHyUoqd7Zhph7r6f7+ufYN48EQ@mail.gmail.com>
 <54BE108F.8090506@samsung.com>
 <CAKohpokSuVhH3hHFF+mLtJXvjt=bmJy1oZRBOttCNXORBS1Y0A@mail.gmail.com>
 <54BE3E10.2080906@samsung.com>
Message-ID: <CAKohpontEntV48XqNcJq+euT9SdEjkgn5Pa=sSUpgM8mfKKCUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2015 at 17:07, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> If each bus-block has separate regulator independently, each bus-block can be registered
> separately. But, exynos bus-blocks in mem-bus-group share the same regulator.

This can be managed easily within the driver. Just stay the highest
voltage requested.
I don't think its not manageable. But it will be much more convenient
as that will show
the correct picture and get rid of unnecessarily virtualizing things..

--
viresh
