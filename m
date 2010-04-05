From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Mon, 5 Apr 2010 22:14:34 +0400
Subject: [PATCH 2/4] Driver for Zipit Z2 battery chip
In-Reply-To: <201004050505.13273.marek.vasut@gmail.com>
References: <201003101741.17840.marek.vasut@gmail.com>
	<f17812d71003211927p2acd79d6i2a72a9ef0a159032@mail.gmail.com>
	<201004050505.13273.marek.vasut@gmail.com>
Message-ID: <20100405181434.GA3316@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 05, 2010 at 05:05:13AM +0200, Marek Vasut wrote:
> Dne Po 22. b?ezna 2010 03:27:59 Eric Miao napsal(a):
> > On Thu, Mar 11, 2010 at 12:41 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > > Hi,
> > > This patch adds driver for Zipit Z2 battery chip called AER915. No
> > > details are known about the chip. The chip is available through I2C bus
> > > at address 0x55 and it's register 0x02 contains battery voltage.
> > >
> > > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> > 
> > Anton Vorontsov Cc'ed.
> > 
> Any updates/objections against merging ?

Nope, looks OK.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

^^ This is for the case if you'd like to pass it via PXA tree
   along with the platform support patch.

If you want me to take this patch via battery-2.6, I can do it
as well, just tell me.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
