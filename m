From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 24 Nov 2010 15:09:25 +0100
Subject: [PATCH 1/9] spi/pxa2xx: don't use subys initcall for driver init
In-Reply-To: <AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
References: <1290597207-29838-1-git-send-email-bigeasy@linutronix.de>	<1290597207-29838-2-git-send-email-bigeasy@linutronix.de>
	<AANLkTin4vh85XRkEd7YocCmKngViR_qZDe7z1b4JXyd-@mail.gmail.com>
Message-ID: <4CED1C95.8070300@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang wrote:
> Hi Sebastian,

Hi Hoajian,

> Actually it's added for cpufreq usage. We can check the commit in below.
> 
>     pxa2xx_spi: register earlier
> 
>     Register pxa2xx_spi earlier so it can be used with cpufreq
> 
> So I think that this modifcation may cause others brokne.

I've been pointed out to this commit but I don't understand _why_.
The part I don't get is "so it can be used with cpufreq". Is it
refered to a driver or the subsystem as it?

> Thanks
> Haojian

Sebastian
