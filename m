From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 21 Dec 2010 09:47:50 +0530
Subject: [PATCH V3 39/63] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <20101220114948.GC28157@n2100.arm.linux.org.uk>
References: <cover.1292833228.git.viresh.kumar@st.com>
	<674f9b1ab90602072d7adcd856453380ed21872b.1292833229.git.viresh.kumar@st.com>
	<20101220111056.GB28157@n2100.arm.linux.org.uk>
	<4D0F3EC1.5030207@st.com>
	<20101220114948.GC28157@n2100.arm.linux.org.uk>
Message-ID: <4D102A6E.6020604@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2010 05:19 PM, Russell King - ARM Linux wrote:
> It is a hack, plain and simple.  You're adding code to misrepresent what
> the hardware can do.  You're fooling the system into thinking that the
> GIC can control wake-up sources, when in fact the GIC has zero wakeup
> capabilities what so ever.

Ok, understood.

I will drop this patch while sending this patchset to your patch tracker.
Also we will send driver fixes separately to respective mailing lists, in 
which we find issue, similar to serial_core.c.

-- 
viresh
