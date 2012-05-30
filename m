From: ki0351.kim@samsung.com (Kyoungil Kim)
Date: Wed, 30 May 2012 18:28:03 +0900
Subject: [PATCH] serial: samsung: protect NULL dereference of clock name
In-Reply-To: <CAM=Q2csPTE=5sc+kxnW6d+trf04OknFtRoxq4NGu8PkoAhOOxg@mail.gmail.com>
References: <001401cd3e3e$644fd3a0$2cef7ae0$%kim@samsung.com>
 <CAM=Q2csPTE=5sc+kxnW6d+trf04OknFtRoxq4NGu8PkoAhOOxg@mail.gmail.com>
Message-ID: <001701cd3e46$8372bce0$8a5836a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti Datta wrote:
> Hi Kim,
> On Wed, May 30, 2012 at 1:59 PM, Kyoungil Kim <ki0351.kim@samsung.com> wrote:
> > From: KeyYoung Park <keyyoung.park@samsung.com>
> >
> > When priting the serial clock source, if clock source name is null,
> > kernel reference NULL point.
> >
> Could you help me understand why is that NULL ? Or the crash that you saw.

When you want to see the serial clock source name like using cat command before you open the tty, 
You can see the kernel crash.
I know this is not normal scenario.
This patch just prevents the kernel panic.
