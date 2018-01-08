From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Jan 2018 13:51:23 -0800
Subject: [PATCH 0/5] Add capture functionality to OMAP pwm driver
In-Reply-To: <20180108153926.GA3916@lenoch>
References: <20180108153926.GA3916@lenoch>
Message-ID: <20180108215123.GU3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ladislav Michl <ladis@linux-mips.org> [180108 15:42]:
> Tony, I wanted to do something easy to understand as a base for
> event capture interrupt, but either I do not understand hardware,
> or it indeed cannot do pulse capture.

Hmm OK. Presumably it works as it's been around for a long time,
I thought any edge trigger will just sample the current counter
value and that's it..

Regards,

Tony
