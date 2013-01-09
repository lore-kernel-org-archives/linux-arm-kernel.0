From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 9 Jan 2013 16:55:37 +0530
Subject: [PATCH 2/3] cpufreq: add imx6q-cpufreq driver
In-Reply-To: <CAKohpo=yahfREsWvCPN6BjoxiifKZWCM19-mLEvao0e4UCT6Vg@mail.gmail.com>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
 <1357628043-19256-3-git-send-email-shawn.guo@linaro.org>
 <CAOh2x=mv9_iWt+y9cP0oA4WKs86Ne9nRP6CgKy_1COnPm57YOA@mail.gmail.com>
 <20130108143554.GC19534@S2101-09.ap.freescale.net>
 <CAKohpomQuoUgPVp6e9_UrK0sk+z26cG36DoxH91LWSmBHD36BQ@mail.gmail.com>
 <20130108150357.GD19534@S2101-09.ap.freescale.net>
 <CAKohpo=yahfREsWvCPN6BjoxiifKZWCM19-mLEvao0e4UCT6Vg@mail.gmail.com>
Message-ID: <CAKohpo=UdnMrrTWHdC9qor+gmqJp9dCp_GV=1wDjsUqhNZwwpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2013 20:49, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 8 January 2013 20:34, Shawn Guo <shawn.guo@linaro.org> wrote:
>> I'm seeing that the .init() will be called on cpu1 when removing the
>> module.
>
> Hmm... Can you give me sometime to think about how to fix that?
> You can go ahead with keeping this change in v2.

Hi Shawn,

I have sent a fix for this and cc'd you. Can you please give it a try?

cpufreq: Simplify __cpufreq_remove_dev()

patches are present here.

http://git.linaro.org/gitweb?p=arm/big.LITTLE/mp.git;a=shortlog;h=refs/heads/cpufreq-fixes-v2
