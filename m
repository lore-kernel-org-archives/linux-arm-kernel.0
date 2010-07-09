From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jul 2010 15:49:01 +0100
Subject: OK to base some patches on lmb branch?
In-Reply-To: <20100707105213.GJ1920@atomide.com>
References: <20100707105213.GJ1920@atomide.com>
Message-ID: <20100709144901.GK22845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 07, 2010 at 01:52:14PM +0300, Tony Lindgren wrote:
> Hi Russell,
> 
> Is your lmb branch going to stay static?

Not at the moment, I'm still tweaking things in there, and the main
lmb conversion commit needs a better description...  I think there's
also a few bits missing from the discontigmem removal patch.
