From: xerofoify@gmail.com (Nick Krause)
Date: Wed, 23 Jul 2014 11:08:51 -0400
Subject: omap-wakeupgen.c: Remove function for fix me
In-Reply-To: <20140723074328.GI18374@atomide.com>
References: <CAPDOMVinWFVKY=mMOA1f6pd4orOgcKh1kE01MPVaLZi0Z_tMmg@mail.gmail.com>
 <20140723074328.GI18374@atomide.com>
Message-ID: <CAPDOMVjrSskMHq0ZdB6mpGJBn9gvbpguLSK-+aHaV9k0QrqzHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 3:43 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Nick Krause <xerofoify@gmail.com> [140722 14:12]:
>> static void __init irq_pm_init(void)
>> 382 {
>> 383         /* FIXME: Remove this when MPU OSWR support is added */
>> 384         if (!soc_is_omap54xx())
>> 385                 cpu_pm_register_notifier(&irq_notifier_block);
>> 386 }
>> I am wondering is this omap supported now if it is can I remove it?
>
> Does REVISIT cause issues for you with cscope? It may be easier to
> replace the cscope bugging FIXME statements with just REVISIT unless
> a real fix is provided.
>
> Regards,
>
> Tony


Very well then , seems like a good idea will try later.
Nick
