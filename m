From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Aug 2017 09:13:22 -0700
Subject: [PATCH v2 0/8] omap*: Fixes/Cleanups for MMC devicetree node
In-Reply-To: <20170807064813.GA5487@atomide.com>
References: <20170607093749.15656-1-kishon@ti.com>
 <CAPDyKFrJh9qAz6q2-TH8rMshuMjDTkT5pHP==FUUH9KZEOehOQ@mail.gmail.com>
 <e9c1cce6-5d6d-3762-8a84-28f36fa3bc33@ti.com>
 <20170807064813.GA5487@atomide.com>
Message-ID: <20170810161322.GD8569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [170806 23:49]:
> * Kishon Vijay Abraham I <kishon@ti.com> [170803 04:20]:
> 
> > Do you want me to resend the entire series or only "ARM: dts: omap*: Replace
> > deprecated "vmmc_aux" with "vqmmc"?
> 
> Seems that the missing one is safe to apply now? If so, let me just
> take a look at that since I do have a branch already set up that
> I can use.

I'll move pdata-quirks change to omap-for-v4.14/soc branch
and will merge and apply the dts changes into
omap-for-v4.14/dt branch.

Thanks,

Tony
