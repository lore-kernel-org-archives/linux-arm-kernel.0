From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Oct 2010 08:49:06 +0200
Subject: at91: input overruns question
In-Reply-To: <AANLkTinbThMFXd1KpuMRYNJREpjGa6RNBH9R1SM955Sd@mail.gmail.com>
References: <AANLkTinbThMFXd1KpuMRYNJREpjGa6RNBH9R1SM955Sd@mail.gmail.com>
Message-ID: <20101026064906.GN8554@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Aras,

On Tue, Oct 26, 2010 at 05:19:30PM +1100, Aras Vaichas wrote:
> I'm updating our production kernel to 2.6.33.7-rt29 for an at91rm9200.
> This is the newest version supported by RT.
> 
> I've noticed that the age-old debug serial input overrun(s) issue has
> gotten far worse and I can no longer use the cursor keys at all. i.e.
> no history on serial console or vi.
> 
> As the kernel version numbers have gone up, the problem seems to have
> gotten worse.
> 
> Is there anything that I can do to make it a bit more usable?
> 
> Any .config changes?
> 
> Is it worse because of the RT patches?
> 
> Please feel free to point me to any previous posts discussing the
> issue, or solutions.
Where does the warning come from?  serial layer, at91 serial driver?
How big is the fifo in the at91 serial device?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
