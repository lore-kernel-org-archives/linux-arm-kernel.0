From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 16 Aug 2017 08:56:56 +0530
Subject: [PATCH 1/4] ARM: dts: augment Ux500 to use DT cpufreq
In-Reply-To: <CACRpkdZ-7yHA4Xz62K53_XM28pTNf1dNLV42Fo-Jzzx5Y7in8g@mail.gmail.com>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
 <20170810125221.25818-2-linus.walleij@linaro.org>
 <20170811051515.GD3638@vireshk-i7>
 <CACRpkdZ-7yHA4Xz62K53_XM28pTNf1dNLV42Fo-Jzzx5Y7in8g@mail.gmail.com>
Message-ID: <20170816032656.GC4233@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-17, 14:23, Linus Walleij wrote:
> On Fri, Aug 11, 2017 at 7:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > For example, below will fail cpufreq on your board. You can try that
> > to make sure I am not dreaming.
> >
> > - Compile cpufreq-dt as a module.
> > - Boot the board.
> > - Offline CPU0 (i.e. Keep only CPU1 online).
> > - Boom, cpufreq failed.
> >
> > This will happen because the CPU1 doesn't have the operating-points
> > and other properties. We should have them in all the CPUs.
> 
> I don't think that will be a problem because CPU0 cannot be
> taken offline on this system.

Should be fine then.

-- 
viresh
