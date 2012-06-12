From: viresh.kumar2@arm.com (viresh kumar)
Date: Tue, 12 Jun 2012 12:13:23 +0100
Subject: [linux-next] "clk: add non CONFIG_HAVE_CLK routines" commit
In-Reply-To: <20120612110929.GA16511@localhost>
References: <20120522234621.GA3610@windriver.com>
 <CAOh2x=mFOPKbzuY__k0RVpFHTdPfa-iN1e3Lpa3iWt9iP6FzFw@mail.gmail.com>
 <20120612110929.GA16511@localhost>
Message-ID: <4FD72453.1040602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/12 12:09, Fengguang Wu wrote:
> Another thing I'm not sure is that the typical clk_get() callers only
> tests IS_ERR() on the returned value. As a clk newbie, I don't know
> whether there will be lots of clk users seeing this (new) NULL value
> on !CONFIG_HAVE_CLK and whether the current behavior is correct..

There have been long discussions over it in past, check this thread

https://lkml.org/lkml/2012/4/24/389

--
Viresh

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
