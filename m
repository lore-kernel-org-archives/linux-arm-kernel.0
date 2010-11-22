From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 22 Nov 2010 20:21:12 +0000
Subject: [PATCH 2/5] omap4: l2x0: Construct the AUXCTRL value using defines
In-Reply-To: <8762vpp19m.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Mon, 22 Nov 2010 12:11:01 -0800")
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-3-git-send-email-santosh.shilimkar@ti.com>
	<8762vpp19m.fsf@deeprootsystems.com>
Message-ID: <yw1xoc9h2jpj.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> This patch removes the hardcoded value of auxctrl value and
>> construct it using bitfields
>>
>> Bit 25 is reserved and is always set to 1. Same value
>> of this bit is retained in this patch
>
> Is this OMAP specific, or is this ARM generic?

The bit fields are generic PL310.  It has to be set from OMAP code due
to the ROM call.

-- 
M?ns Rullg?rd
mans at mansr.com
