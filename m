From: srinidhikasagar@gmail.com (srinidhi kasagar)
Date: Tue, 18 May 2010 14:55:21 +0530
Subject: [PATCH] Watchdog: Adding support for Watchdog found with ARM
	CortexA9
In-Reply-To: <4BF12767.4010402@st.com>
References: <1274090044-10236-1-git-send-email-viresh.kumar@st.com>
	<AANLkTil2PtnsKdAHvW5-1WMQyTj6v3uLtrn2CNaZSXkc@mail.gmail.com>
	<4BF12767.4010402@st.com>
Message-ID: <AANLkTikCC108eWniEBwzYsbkEUYQocICaLtd7FD_vMQ1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I do not understand why a new driver is required while having similar one
for MPCore watchdog.
Please have a look at drivers/watchdog/mpcore_wdt.c

srinidhi

On Mon, May 17, 2010 at 4:54 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:

> On 5/17/2010 4:14 PM, Jassi Brar wrote:
> > On Mon, May 17, 2010 at 6:54 PM, Viresh KUMAR <viresh.kumar@st.com>
> wrote:
> >> Watchdog details can be found in ARM Cortex A9 reference manual at:
> >>
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0407e/indix.html
> > The link doesn't work.
> >
>
> Sorry!! i will correct it in V2.
> till then replace indix.html with index.html.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100518/484ac2b7/attachment.htm>
