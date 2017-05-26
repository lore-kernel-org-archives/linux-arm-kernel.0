From: afzal.mohd.ma@gmail.com (afzal mohammed)
Date: Fri, 26 May 2017 16:52:10 +0530
Subject: [CFT] Always enable SMP mode on MP capable CPUs
In-Reply-To: <20170525221332.GE10472@atomide.com>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <CAOMZO5Da2R2_t2nU+MdrJiSzvcBQKS4pwYS96r4UyfGc8DtWww@mail.gmail.com>
 <CAOMZO5Dc=i7UdQH=r5RRr_4GmyZZT+rh7BTNV4WbfqKvtVDfsw@mail.gmail.com>
 <20170519171526.GW22219@n2100.armlinux.org.uk>
 <20170524153847.GY10472@atomide.com>
 <20170525144800.GV23750@n2100.armlinux.org.uk>
 <20170525151103.GC10472@atomide.com>
 <20170525180540.GW23750@n2100.armlinux.org.uk>
 <20170525221332.GE10472@atomide.com>
Message-ID: <20170526112210.GA3354@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 25, 2017 at 03:13:33PM -0700, Tony Lindgren wrote:

> OK so got my am437x-idk back
> 
> And as suspected it won't boot with these changes.

Tested here too with your additional changes included & seeing same
behavior here as well on AM437x.

As an aside, when Russell posted this patch a week back itself was
suspecting this. i had a certain view on AM437x w.r.t SMP issue back
while officially working on it & since now not officially involved
with the issue at hand, i was uncomfortable dealing with this. But as
Russell's patch was not noticed by others w.r.t AM437x, upon being
able to confirm it yesterday, i at least wanted to bring it to notice
& runaway from the scene.

Regards
afzal
