From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 18 Jan 2010 14:41:20 +0100
Subject: Use of data types
In-Reply-To: <2703439e1001180443t761947e0idc144ced64ca3a4f@mail.gmail.com>
References: <2703439e1001180443t761947e0idc144ced64ca3a4f@mail.gmail.com>
Message-ID: <20100118134120.GB31345@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jan 18, 2010 at 09:43:12PM +0900, Khushhua Mogambo wrote:
> Hi
>   I starting to port Linux kernel to my companies new ARM based
> SoC and development board.
> 
> Some of the regs is 16bits wide and some is 32bits width. I ask if
> my using u16 and u32 in place of 'unsigned short' and 'unsigned int'
> in the whole porting would be acceptable or not?
> 
> In different wording, using only u16 and u32 always is considered good
> quality or bad?
I prefer using u32 over int.  Still more if your register space isn't uniform.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
