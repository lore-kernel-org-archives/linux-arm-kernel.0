From: johnstul@us.ibm.com (john stultz)
Date: Mon, 12 Sep 2011 18:16:00 -0700
Subject: [PATCH 10/24] C6X: time management
In-Reply-To: <1314826019-22330-11-git-send-email-msalter@redhat.com>
References: <1314826019-22330-1-git-send-email-msalter@redhat.com>
	<1314826019-22330-11-git-send-email-msalter@redhat.com>
Message-ID: <CANcMJZBxCQFgAsO89X+_SSm02vtseRhY7ozoxik4UMEuJUdDNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 2:26 PM, Mark Salter <msalter@redhat.com> wrote:
> The C6X architecture includes a 64-bit free running core clock counter which
> is used as the clocksource. The SoCs have a number of 64-bit programmable
> timers. One of these is used as the clockevent timer.
>
> Signed-off-by: Mark Salter <msalter@redhat.com>

Sort of a tangent to this specific patch, but since it came up
recently in the x32 discussion, I wanted to check if you were using a
64bit definition of time_t?

thanks
-john
