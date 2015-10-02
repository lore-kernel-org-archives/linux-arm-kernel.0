From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 02 Oct 2015 15:14:18 +0100
Subject: [PATCH] ARM: debug: add support for alternate 8250 register layout
In-Reply-To: <1443787929-19173-1-git-send-email-mans@mansr.com> (Mans
 Rullgard's message of "Fri, 2 Oct 2015 13:12:08 +0100")
References: <1443787929-19173-1-git-send-email-mans@mansr.com>
Message-ID: <yw1x612pmk79.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mans Rullgard <mans@mansr.com> writes:

> Some SoCs have a UART with a non-standard register layout. This
> allows the debug console to work with these.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> I would have preferred a more accurate description of the UART, but I've
> not managed to figure out who the vendor is.

I've been informed it is provided by Palmchip.  I'll make a new patch.

-- 
M?ns Rullg?rd
mans at mansr.com
