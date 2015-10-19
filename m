From: dianders@chromium.org (Doug Anderson)
Date: Mon, 19 Oct 2015 08:11:06 -0700
Subject: [PATCH 3/3] ARM: dts: exynos5422-odroidxu3: Added UHS-I bus speed
 support
In-Reply-To: <CANAwSgSd8sHDcmGmck=Em2H5WJzVWM28cbvs9z6CFgpuTY_Juw@mail.gmail.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-3-git-send-email-linux.amoon@gmail.com>
 <561B48B7.1040201@samsung.com>
 <CANAwSgSLFviT4ZNXTYwxYs2pbrr9ozJmPMauhgRPO0556Rsr_g@mail.gmail.com>
 <561C4CEE.3050905@samsung.com>
 <CANAwSgRJ+5O-x61K9E_AxTZWQy3jJrKF5MiLtWRdUU29CCfa-Q@mail.gmail.com>
 <561C7DF1.6000609@samsung.com>
 <CANAwSgRBzFqHB98wSQnQu-ggGqRT2H6wC415wULXVhPg0uw_3A@mail.gmail.com>
 <561D9ACE.6050103@samsung.com>
 <CAGOxZ51uPkdGmCAs2Tc8_=YvkORJKdivN47vo1ZxkGQ-MY=-oQ@mail.gmail.com>
 <CAD=FV=Voh6Xh_naWQTaRPP8YUS2xJh7jfA+zYbH9QdVhmyZz9A@mail.gmail.com>
 <CANAwSgSd8sHDcmGmck=Em2H5WJzVWM28cbvs9z6CFgpuTY_Juw@mail.gmail.com>
Message-ID: <CAD=FV=WaD6BuJbSJKTCy4MoG125EMYvnBqYKRTixXL7Gz=YnvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 19, 2015 at 3:11 AM, Anand Moon <linux.amoon@gmail.com> wrote:
> 1 Drop the cd-gpios changes. pinctrl-0 changes.

Right.


> 2 Fix the regulator changes for vmmc/vqmmc with disable of regulator-always-on;

I'm not totally sure I understand.  You should need to keep vmmc and
vqmmc always on because otherwise you can't do card detection (unless
you poll for card detect).


> 3 Drop this UHS-I changes as if now.

Sounds right.
