From: david-b@pacbell.net (David Brownell)
Date: Fri, 30 Jul 2010 11:46:24 -0700 (PDT)
Subject: [PATCH RFC] usb gadget: introduce usb_gadget_probe_driver
In-Reply-To: <20100730152602.GA28042@pengutronix.de>
Message-ID: <254168.47917.qm@web180307.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> - The bind functions are only called at init time, so there
> is no need
> ? to save a pointer to it.

Right.  Let's retain the space-saving behaviors
by keeping init-only code in init sections.

- Dave
