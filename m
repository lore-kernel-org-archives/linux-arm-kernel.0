From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 11 Jun 2010 07:30:49 +0200
Subject: [PATCH resend] Watchdog: Adding support for ARM Primecell
	SP805 Watchdog
In-Reply-To: <4C11B711.70907@st.com>
References: <1275465783-14052-1-git-send-email-viresh.kumar@st.com>
	<4C11B711.70907@st.com>
Message-ID: <20100611053049.GM3788@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

Still need to look at it. First finishing up another project.
Probably for this weekend.

Kind regards,
Wim.

> On 6/2/2010 1:33 PM, Viresh KUMAR wrote:
> > Technical Reference Manual can be found at:
> > http://infocenter.arm.com/help/topic/com.arm.doc.ddi0270b/DDI0270.pdf
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> > ---
> >  drivers/watchdog/Kconfig     |    7 +
> >  drivers/watchdog/Makefile    |    1 +
> >  drivers/watchdog/sp805_wdt.c |  386 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 394 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/watchdog/sp805_wdt.c
> > 
> 
> Wim,
> 
> Is this patch fine or do i need to send V2?
> 
> viresh.
