From: david-b@pacbell.net (David Brownell)
Date: Wed, 24 Nov 2010 19:59:37 -0800 (PST)
Subject: [PATCH v2 1/4] drivers: hwspinlock: add generic framework
In-Reply-To: <AANLkTi=JSuJCqceJ3iw3TnV5OeJd+e5T3CyHtWVzBRu_@mail.gmail.com>
Message-ID: <536589.12568.qm@web180310.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My rule of thumb is that nothing is "generic"
until at least three whatever-it-is instances
plug in to it.  Sometimes this is called
the "Rule of Three".

Other than OMAP, what's providing hardware
spinlocks that plug into this framework?

- Dave
