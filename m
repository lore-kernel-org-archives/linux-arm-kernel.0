From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 25 Mar 2014 15:59:46 -0700
Subject: [PATCH v0 01/15] drivers: clk: st: Support for DIVMUX and PreDiv
 Clocks
In-Reply-To: <53313E39.9080605@st.com>
References: <1393514668-17440-1-git-send-email-gabriel.fernandez@st.com>
 <1393514668-17440-2-git-send-email-gabriel.fernandez@st.com>
 <20140325052725.32624.39974@quantum> <53313E39.9080605@st.com>
Message-ID: <20140325225946.5762.56339@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Gabriel Fernandez (2014-03-25 01:28:41)
> Hi Mike,
> 
> I want that you take theses patches directly.

Sure, I've taken patches #1-10 into clk-next.

Regards,
Mike

> 
> Many thanks
> 
> 
> Best regards
> 
> Gabriel.
> 
> 
> On 03/25/2014 06:27 AM, Mike Turquette wrote:
> > Quoting Gabriel FERNANDEZ (2014-02-27 07:24:14)
> >> +/**
> >> + * DOC: Clock mux with a programmable divider on each of its three inputs.
> >> + *      The mux has an input setting which effectively gates its output.
> >> + *
> >> + * Traits of this clock:
> >> + * prepare - clk_(un)prepare only ensures parent is (un)prepared
> > Minor nitpick but it doesn't look like .prepare or .unprepare are
> > supported below. It looks like this copy/paste comment applies to most
> > of the clk patches as well.
> >
> > It's a small problem and doesn't require a patch respin. But perhaps can
> > be cleaned up some day in the future.
> >
> > Do you want me to take these patches directly or are you just looking
> > for an Ack?
> >
> > Regards,
> > Mike
> 
