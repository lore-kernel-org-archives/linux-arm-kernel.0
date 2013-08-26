From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 26 Aug 2013 17:31:13 +0200
Subject: [RFC 17/17] clk: zynq: remove call to of_clk_init
In-Reply-To: <521B70D1.5090506@monstr.eu>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-18-git-send-email-sebastian.hesselbarth@gmail.com>
 <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
 <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
 <20130823073250.GB30135@pengutronix.de>
 <521B38BF.6040400@monstr.eu>
 <20130826120716.GB24795@pengutronix.de>
 <521B4FCF.5000904@gmail.com> <521B70D1.5090506@monstr.eu>
Message-ID: <20130826153113.GD24795@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Mon, Aug 26, 2013 at 05:14:25PM +0200, Michal Simek wrote:
> Steffen: Can you point me to that floading patches? If they are useful
> we can try them and help with pushing them to the mainline.
> I don't think that there is any reasonable solution without using these
> patches.
> 

I was referring to the RFC from Thierry https://lkml.org/lkml/2013/8/16/399
It sounds like it might help, but also that this might lead to unwanted
side effects.

str

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
