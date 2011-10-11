From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Tue, 11 Oct 2011 12:46:07 +0530
Subject: sched: ARM: arch_scale_freq_power
In-Reply-To: <CAKfTPtB3sLWq5fHOTrFg6vfHSKnz2i17oYx9Btr0u_tWV2bsjQ@mail.gmail.com>
References: <CAKfTPtB3sLWq5fHOTrFg6vfHSKnz2i17oYx9Btr0u_tWV2bsjQ@mail.gmail.com>
Message-ID: <CAP245DX8b45Nj5SAwtLivp_vMKpwfeUrqnR2sqjnVyqiRd61gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding Peter to the discussion..

On Thu, Oct 6, 2011 at 5:06 PM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> I work to link the cpu_power of ARM cores to their frequency by using
> arch_scale_freq_power. It's explained in the kernel that cpu_power is
> used to distribute load on cpus and a cpu with more cpu_power will
> pick up more load. The default value is SCHED_POWER_SCALE and I
> increase the value if I want a cpu to have more load than another one.
> Is there an advised range for cpu_power value as well as some time
> scale constraints for updating the cpu_power value ?
> I'm also wondering why this scheduler feature is currently disable by default ?
>
> Regards,
> Vincent

In discussions with Vincent regarding this, I've wondered whether
cpu_power wouldn't be better renamed to cpu_capacity since that is
what it really seems to describe.
