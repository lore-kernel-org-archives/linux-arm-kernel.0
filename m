From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Nov 2015 16:28:49 -0800
Subject: [PATCH 5/5] clk: scpi: add missing of_node_put
In-Reply-To: <CAPKp9uZH71gzAhhbuk-tGOxrQ3jXS1Ot4NpTW7Jx5nhrwi7bfg@mail.gmail.com>
References: <1445460100-26727-1-git-send-email-Julia.Lawall@lip6.fr>
 <1445460100-26727-6-git-send-email-Julia.Lawall@lip6.fr>
 <5628AA99.1000000@arm.com>
 <CAPKp9uZH71gzAhhbuk-tGOxrQ3jXS1Ot4NpTW7Jx5nhrwi7bfg@mail.gmail.com>
Message-ID: <20151201002849.GD21446@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26, Sudeep Holla wrote:
> Hi Mike/Stephen,
> 
> On Thu, Oct 22, 2015 at 10:21 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> >
> > Thanks for the fix.
> >
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > PS: Since this driver is queued via arm-soc, it needs to go via them or
> > wait for v4.4-rc1 and then queue via clk tree.
> >
> 
> Now that the driver is in mainline, can you take this fix via clk tree for
> you next -rc fixes ?
> 

Sure.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
