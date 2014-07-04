From: spk.linux@gmail.com (Sachin Kamat)
Date: Fri, 4 Jul 2014 16:53:41 +0530
Subject: [PATCH] thermal: Add missing cpumask_clear
In-Reply-To: <000001cf9771$e2f465c0$a8dd3140$@samsung.com>
References: <000001cf9771$e2f465c0$a8dd3140$@samsung.com>
Message-ID: <CAK5sBcHDTgyj67xVWgtNH-Z7XU1Ykp6m650_mWBVp=Az2P6f=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonghwan,

On Fri, Jul 4, 2014 at 3:52 PM, Jonghwan Choi <jhbird.choi@samsung.com> wrote:
> Cpumasks should be cleared before using.

Please explain why and what is issue observed without this.

>
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> ---

-- 
Regards,
Sachin.
