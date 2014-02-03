From: olof@lixom.net (Olof Johansson)
Date: Sun, 2 Feb 2014 19:59:44 -0800
Subject: [PATCH 0/3] kconfig selection fixes
In-Reply-To: <1391294144-27787-1-git-send-email-robherring2@gmail.com>
References: <1391294144-27787-1-git-send-email-robherring2@gmail.com>
Message-ID: <20140203035944.GB20055@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 01, 2014 at 04:35:41PM -0600, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Olof,
> 
> Here are a few kconfig select fixes. The first one can be squashed into
> my previous patch for HiSilicon removing SMP select if you want to. 
> 
> I'm still looking into the cpufreq select issue with highbank. I'll
> follow-up with Viresh on that.

Since I had already applied the first version of the hisi patch (and sent the
pull request for it), I held this off until -rc1. I've applied it to fixes now,
so it'll be in the next batch we send up.

Thanks!


-Olof
