From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 Nov 2015 17:29:27 +0000
Subject: [PATCH 5/5] clk: scpi: add missing of_node_put
In-Reply-To: <5628AA99.1000000@arm.com>
References: <1445460100-26727-1-git-send-email-Julia.Lawall@lip6.fr>
 <1445460100-26727-6-git-send-email-Julia.Lawall@lip6.fr>
 <5628AA99.1000000@arm.com>
Message-ID: <CAPKp9uZH71gzAhhbuk-tGOxrQ3jXS1Ot4NpTW7Jx5nhrwi7bfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike/Stephen,

On Thu, Oct 22, 2015 at 10:21 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> Thanks for the fix.
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>
> PS: Since this driver is queued via arm-soc, it needs to go via them or
> wait for v4.4-rc1 and then queue via clk tree.
>

Now that the driver is in mainline, can you take this fix via clk tree for
you next -rc fixes ?

Regards,
Sudeep
