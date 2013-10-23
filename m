From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 23 Oct 2013 19:55:12 +0530
Subject: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
In-Reply-To: <20131023135116.GC31126@lunn.ch>
References: <1382533461-31021-1-git-send-email-andrew@lunn.ch>
 <CAKohpombg7mAmgxxvUg8kz1MaFwcycR1eL0UrgELY2WdGfrAag@mail.gmail.com>
 <20131023135116.GC31126@lunn.ch>
Message-ID: <CAKohpokTgCz0c=PeaJHKiZEiYc0jPVq-vwkhP5pM0hh1-0QnLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 October 2013 19:21, Andrew Lunn <andrew@lunn.ch> wrote:
> There does seem to be a convention that kernel.h and module.h come
> first, and then i have the rest in order.

Atleast I am not aware of any such convention and so got
confused.

> +/*
> + * Handle the interrupt raised when the frequency change is
> + * complete.
> + */
> +static irqreturn_t dove_cpufreq_irq(int irq, void *dev)
> +{
> +       return IRQ_HANDLED;
> +}
>
> What more would you like to see in the comment?

Ahh.. I read it as "Commented interrupt handler and so it is no
more registered" :)

So, you have actually tested your code without interrupt handler?
What exactly happens in that case?
