From: ccross@android.com (Colin Cross)
Date: Fri, 27 May 2011 09:24:12 -0700
Subject: Tegra board updates for 2.6.40
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A4870C@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A4870C@HQMAIL01.nvidia.com>
Message-ID: <BANLkTikFjz6QfsaHsMbzXeLLB8azOcdGBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 11:00 AM, Stephen Warren <swarren@nvidia.com> wrote:
> Colin,
>
> You had mentioned not taking any board updates for Tegra for 2.6.40.
>
> Could you please consider taking at least the following one patch:
>
> http://www.spinics.net/lists/linux-tegra/msg01396.html
>
> This is a simple bug-fix rather than new feature etc. Without this,
> audio on Harmony, which previously worked fine, fails to initialize
> due to the conflicting attempted GPIO registrations. (I *think*
> Harmony still boots OK without the fix, but I vaguely remember
> the fix being needed just to boot, but I'm probably wrong about that)
>
> Thanks!

Sure, I can take bug fixes.
