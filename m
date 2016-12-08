From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 08 Dec 2016 16:48:18 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <20161208163755.GH6408@localhost> (Vinod Koul's message of "Thu,
 8 Dec 2016 22:07:55 +0530")
References: <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com> <20161207164341.GX6408@localhost>
 <yw1xr35j1yd5.fsf@unicorn.mansr.com> <20161208103921.GC6408@localhost>
 <91b0d10c-1bc2-c3e1-4088-f4ad9adcd6c0@free.fr>
 <20161208163755.GH6408@localhost>
Message-ID: <yw1xy3zqxt7x.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> To make it efficient, disregarding your Sbox HW issue, the solution is
> virtual channels. You can delink physical channels and virtual channels. If
> one has SW controlled MUX then a channel can service any client. For few
> controllers request lines are hard wired so they cant use any channel. But
> if you dont have this restriction then driver can queue up many transactions
> from different controllers.

Have you been paying attention at all?  This exactly what the driver
ALREADY DOES.

-- 
M?ns Rullg?rd
