From: khilman@ti.com (Kevin Hilman)
Date: Fri, 07 Jan 2011 13:14:07 -0800
Subject: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix for
	undefined reference to 'omap2_prm_read_mod_reg'
In-Reply-To: <e194160102cb8b695465c81eea6582fc@mail.gmail.com> (Santosh
	Shilimkar's message of "Fri, 7 Jan 2011 16:44:05 +0530")
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	<1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1101061056340.22048@utopia.booyaka.com>
	<e194160102cb8b695465c81eea6582fc@mail.gmail.com>
Message-ID: <87r5comn6o.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

[...] 

>> I think it would be best to use WARN() on these, rather than
>> WARN_ONCE().  That's because these could be called from different
>> parts of the code base, and the stack backtrace will help someone
>> figure out all the code that needs to be fixed.
>>
>> Once you do that, this patch is
>>
>> Acked-by: Paul Walmsley <paul@pwsan.com>
>>

> With WARN() instead of WARN_ONCE() and Paul's ack, here
> is an updated patch.

Thanks, will queue for .38-rc cycle.

I'll again plead for working on your git-send-email setup.  It looks
like your using outlook.  The inline patch is wrapped (as outlook almost
always does.)  The attached version applied fine, but the strong
preference is for a single inline patch.  

Thanks,

Kevin
