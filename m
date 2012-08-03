From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Fri, 3 Aug 2012 20:47:40 +0530
Subject: [PATCH v6 0/3] Updated Cortex-M3 series
In-Reply-To: <20120803145035.GJ2626@pengutronix.de>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201208031407.09092.arnd@arndb.de>
 <20120803145035.GJ2626@pengutronix.de>
Message-ID: <20120803151740.GZ2005@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Fri, Aug 03, 2012 at 10:50:35PM +0800, Uwe Kleine-K?nig wrote:
> On Fri, Aug 03, 2012 at 02:07:08PM +0000, Arnd Bergmann wrote:
> > Is it possible to build a NOMMU kernel that runs on both
> > ARMv7-A amd ARMv7-M, in other words is ARMv7-M compatible with
> > ARMv7-A (or ARMv7-R for that matter) if you don't use the MMU?
>
> the instructions to enable and disable irqs are different, so
> we'd need another indirection at least there. Also the whole
> exception model is different. So I'd say it's too different to
> target for a common kernel for the A, R and M profiles.

We are using standard Linux kernel (v3.3) with MMU disabled on
a Cortex R4 system.

--
regards
Shiraz
