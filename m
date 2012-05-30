From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Wed, 30 May 2012 14:37:56 +0530
Subject: [PATCH] serial: samsung: protect NULL dereference of clock name
In-Reply-To: <001401cd3e3e$644fd3a0$2cef7ae0$%kim@samsung.com>
References: <001401cd3e3e$644fd3a0$2cef7ae0$%kim@samsung.com>
Message-ID: <CAM=Q2csPTE=5sc+kxnW6d+trf04OknFtRoxq4NGu8PkoAhOOxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kim,
On Wed, May 30, 2012 at 1:59 PM, Kyoungil Kim <ki0351.kim@samsung.com> wrote:
> From: KeyYoung Park <keyyoung.park@samsung.com>
>
> When priting the serial clock source, if clock source name is null,
> kernel reference NULL point.
>
Could you help me understand why is that NULL ? Or the crash that you saw.
