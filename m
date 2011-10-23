From: mturquette@ti.com (Turquette, Mike)
Date: Sun, 23 Oct 2011 09:50:24 -0700
Subject: [PATCH v2 2/7] clk: Implement clk_set_rate
In-Reply-To: <20111023142458.GE1401@S2100-06.ap.freescale.net>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-3-git-send-email-mturquette@ti.com>
	<20111023142458.GE1401@S2100-06.ap.freescale.net>
Message-ID: <CAJOA=zM=Sq4aQY4kNFyBv4Loft+ZfW6mhHOwFY_kJt+oVdxr9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 7:24 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Thu, Sep 22, 2011 at 03:26:57PM -0700, Mike Turquette wrote:
>> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> [...]
>
>> + * @set_rate Change the rate of this clock. If this callback returns
>> + * ? ? ? ? ? CLK_SET_RATE_PROPAGATE, the rate change will be propagated to
>
> s/CLK_SET_RATE_PROPAGATE/CLK_PARENT_RATE_CHANGE, as suggested by your
> change log above?

Thanks for reviewing.  Will roll into V3 patchset.

Regards,
Mike

>
>> + * ? ? ? ? ? the parent clock (which may propagate again). The requested
>> + * ? ? ? ? ? rate of the parent is passed back from the callback in the
>> + * ? ? ? ? ? second 'unsigned long *' argument.
>> + *
>
> --
> Regards,
> Shawn
>
>
