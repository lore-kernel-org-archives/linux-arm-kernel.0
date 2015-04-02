From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Apr 2015 17:55:47 +0100
Subject: [PATCH 1/3] mfd: ucb1x00: add irq field to the platform data
In-Reply-To: <CALT56yM-JSN=8KR3EUFAa+k4ZZkqXY9zgwzT2PhRn23dMUc3rQ@mail.gmail.com>
References: <1427989307-1805-1-git-send-email-dbaryshkov@gmail.com>
 <20150402160252.GO24899@n2100.arm.linux.org.uk>
 <CALT56yM-JSN=8KR3EUFAa+k4ZZkqXY9zgwzT2PhRn23dMUc3rQ@mail.gmail.com>
Message-ID: <20150402165547.GV24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 07:27:24PM +0300, Dmitry Eremin-Solenikov wrote:
> Because using static configuration would allow me to drop a nice piece
> of code. Because it would allow later to use dts to describe ucb1x00
> configuration. Because I will no longer have to think whether ucb1x00I h
> driver barfing on IRQ is a problem of a chip, of an IRQ or just me having
> touched wrong GPIO line at wrong time with a scope probe. Yes, I didn't
> put all these causes to the commit description. Do you really want it?

What I want is a decent commit description, one which isn't airy fairy
and looks like it's just mindless churn.  That's all.

It's what every other kernel developer wants to know.  This is precisely
what the ARM ecosystem has been soo bad at for decades.

It matters.  It's one of the things what pisses Linus off.  What Linus
sees from ARM people is lots and lots of apparently pointless churn
which he doesn't understand - and part of that problem is that ARM
people do _not_ justify in their commit messages why a change is
necessary.

So please, improve the commit messages and justify the commits.

It really doesn't help that all that was posted was three patches and
no covering message which could either explain what the three patches
were trying to achieve.  Like most people do.  (And some people take
that to an extreme, posting a cover message for just one patch.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
