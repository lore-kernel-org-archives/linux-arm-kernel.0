From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Tue, 15 Jul 2014 09:33:21 +0530
Subject: [PATCH 1/3 v6] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <20140714191533.GH6800@sirena.org.uk>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
 <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
 <20140714172524.GH6800@sirena.org.uk>
 <CAHfPSqAzab931yurSs+3zj=uoFj93FuAdd24AQKm1fZm07Nq8Q@mail.gmail.com>
 <20140714191533.GH6800@sirena.org.uk>
Message-ID: <CAHfPSqAgCbfL2nkrfSYNJZitT-nGw7+5fpR9FMaabmwVJM6jUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 15 July 2014 00:45, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 15, 2014 at 12:31:32AM +0530, Naveen Krishna Ch wrote:
>
>> in this case spi-s3c64xx.c will continue to ignore the generic SPI "cs-gpios"
>> implementation.
>
>> I'm willing to implement any suggestion to fix this issue.
>
> The problem isn't what you're trying to do, the problem is verifying
> that it has been done correctly - making sure that everything has been
> accounted for in the change itself.

Understand your concern. I will try to get it tested on as many platforms.

-- 
Thanks for your review.
(: Naveen :)
