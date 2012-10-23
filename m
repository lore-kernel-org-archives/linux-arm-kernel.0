From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Tue, 23 Oct 2012 23:20:45 +0530
Subject: [RFC] ARM: OMAP: hwmod: wait for sysreset complete after enabling
 hwmod
In-Reply-To: <87k3uhb26c.fsf@deeprootsystems.com>
References: <1350922532-26338-1-git-send-email-t-kristo@ti.com>
 <87zk3edvti.fsf@deeprootsystems.com>
 <CAM=Q2cvLc63tGMG1t1wguiMHqNxcrZ60GF+fHjxc6_8c7rBykw@mail.gmail.com>
 <87k3uhb26c.fsf@deeprootsystems.com>
Message-ID: <CAM=Q2ctG2Q8o9g7QZEF_uPM+XYXk2tPim-k4Wx7YJzzJHNhVTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 9:39 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Shubhrajyoti Datta <omaplinuxkernel@gmail.com> writes:
[...]
>
> Could you please explain what worked and didn't work on each platforms?
>
> Also, which 3430 did you test on?  If it's SDP, then it has a UART1
> console, correct?
idle mode

set autosuspend for uart
sleep

off count didnt increment on 3430sdp.

hope not hitting any setup at my end.

>
> Kevin
