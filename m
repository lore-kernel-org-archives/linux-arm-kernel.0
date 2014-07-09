From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 09 Jul 2014 19:39:42 +0200
Subject: [RFC PATCH 2/4] tty: serial: 8250 core: allow to overwrite &
 export serial8250_startup()
In-Reply-To: <20140707140946.6f16f2e4@alan.etchedpixels.co.uk>
References: <1404491651-1388-1-git-send-email-bigeasy@linutronix.de>	<1404491651-1388-2-git-send-email-bigeasy@linutronix.de>
 <20140707140946.6f16f2e4@alan.etchedpixels.co.uk>
Message-ID: <53BD7E5E.7020203@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2014 03:09 PM, One Thousand Gnomes wrote:
> On Fri,  4 Jul 2014 18:34:09 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
>> The OMAP version of the 8250 can actually use 1:1 serial8250_startup().
>> However it needs to be extended by a wakeup irq which should to be
>> requested & enabled at ->startup() time.
>>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Acked-by: Alan Cox <alan@linux.intel.com>

Thank you. I added to this patch the counterpart function (->shutdown)
and therefore not yet adding the acked-by.

Sebastian
