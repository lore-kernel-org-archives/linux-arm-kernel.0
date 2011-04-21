From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 21 Apr 2011 23:33:44 +0200
Subject: [PATCH] pxa/mioa701: use gpio arrays for global and gsm gpio
	initialization
In-Reply-To: <1303329331.21545.7.camel@flow> (Philipp Zabel's message of "Wed\,
	20 Apr 2011 21\:55\:28 +0200")
References: <1303329331.21545.7.camel@flow>
Message-ID: <87tydre1c7.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philipp Zabel <philipp.zabel@gmail.com> writes:

> gpio_request_arrays() / gpio_free_arrays() are functional replacements for
> mio_gpio_request() / mio_gpio_free(), which are now obsolete.
>
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

--
Robert
