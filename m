From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 10 Oct 2011 17:29:13 +0100
Subject: [PATCH] fix ehci alignment error
In-Reply-To: <20111010141402.GA21856@suse.de> (Greg KH's message of "Mon, 10
	Oct 2011 07:14:02 -0700")
References: <20111010124154.464239811@gmail.com>
	<20111010141402.GA21856@suse.de>
Message-ID: <yw1xipnwzu7a.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg KH <gregkh@suse.de> writes:

> On Mon, Oct 10, 2011 at 02:38:27PM +0200, Harro Haan wrote:
>> The Kirkwood gave an unaligned memory access error on
>> line 742 of drivers/usb/host/echi-hcd.c:
>> "ehci->last_periodic_enable = ktime_get_real();"
>
> What is "The Kirkwood"?  What size processor is this?

It's an ARM926-like CPU from Marvell.

-- 
M?ns Rullg?rd
mans at mansr.com
