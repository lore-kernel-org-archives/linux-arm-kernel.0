From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 12 Feb 2018 12:40:34 +0530
Subject: [PATCH V6 Resend 00/13] drivers: Boot Constraint core
In-Reply-To: <20180125110125.GA3307@vireshk-i7>
References: <cover.1515554879.git.viresh.kumar@linaro.org>
 <CAL_Jsq+CtWCKENTQmiveoubxU4cDi9QBcpgvYZVfxPNsT-VX+g@mail.gmail.com>
 <20180125110125.GA3307@vireshk-i7>
Message-ID: <20180212071034.GP28462@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-01-18, 16:31, Viresh Kumar wrote:
> So AFAICT the basic problem I was trying to solve still exists with simple-fb
> as well. And the problem is that nothing prevents another driver to get probed
> before the display driver (or simple-fb) and reconfigure the resources. Even if
> we let simple-fb come up really early, the resources like clk/regulator may not
> be available. And so the ordering thing is still unsolved for me.

Ping !!

I understand your concerns Rob, they are surely genuine and I can't
deny that. But I don't see a cleaner "way" (Or "Hack", if you want to
call it that way), to solve these ugly problems.

-- 
viresh
