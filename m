From: stillcompiling@gmail.com (Joshua Clayton)
Date: Tue, 17 Nov 2015 11:21:12 -0800
Subject: [PATCH 2/8] Documentation/spi/spidev_test.c: clean up input_tx
In-Reply-To: <20151117174333.GY31303@sirena.org.uk>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <7f2139b27013d77993c6bc2b0a6c94fab01add98.1447773299.git.stillcompiling@gmail.com>
 <20151117174333.GY31303@sirena.org.uk>
Message-ID: <5345436.HCqatbevmx@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 17, 2015 05:43:33 PM Mark Brown wrote:
> On Tue, Nov 17, 2015 at 07:24:22AM -0800, Joshua Clayton wrote:
> > Put input from string into its own function.
> 
> Again, why are we doing this?  I'm having a hard time seeing what the
> gain is, the amount of code being moved is tiny.

It takes some clutter out of main() whose scope is limited to that little block of code, 
and because in the next patch we add another (larger)function to the if/else block.

I don't know if it is valid to say "look at the next commit" for justification, but
That is the reason.

-- 
~Joshua Clayton
