From: david-b@pacbell.net (David Brownell)
Date: Wed, 17 Nov 2010 07:25:33 -0800 (PST)
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <20101117133136.GA19488@rakim.wolfsonmicro.main>
Message-ID: <781931.83221.qm@web180301.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Tue, Nov 16, 2010 at 07:17:18PM
> -0500, Cyril Chemparathy wrote:
> 
> > The ability to wait on multiple devices may come
> handy.

... You mean you'd like to add such a 
mechanism to the framework? 

Or do you want a driver-specific
mechanism (non-portable)?


 If I had
to do that, I'd just use existing
kernel mechanisms to wait, and then
issue SPI transactions as needed.
Portable, straightforward.
