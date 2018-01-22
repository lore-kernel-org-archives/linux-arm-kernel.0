From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 22 Jan 2018 15:46:45 +0530
Subject: [PATCH v1 2/4] cpufreq: mediatek: Add mediatek related projects
 into blacklist
In-Reply-To: <1516610369.12197.20.camel@mtkswgap22>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1512713278-17807-3-git-send-email-andrew-sh.cheng@mediatek.com>
 <20171211075532.GB25177@vireshk-i7>
 <1516610369.12197.20.camel@mtkswgap22>
Message-ID: <20180122101645.GG2421@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22-01-18, 16:39, Sean Wang wrote:
> Hi, Rafael and Viresh
> 
> Can you kindly guide me how to let the patch also be applied to 4.14 and
> 4.15 tree? Do I need to submit another patches for them?
> 
> These trees really need them. Otherwise, multi_v7_defconfig setup will
> cause an occasional hang or unexpected behaviors on related boards as
> [1] kernelci reported :-(

You need to send them for stable kernels, just follow the following doc on how
to send patches for stable kernels.

Documentation/process/stable-kernel-rules.rst

-- 
viresh
