From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Apr 2014 20:48:17 +0200
Subject: [PATCH 0/3] ARM: PCI: implement virtual PCI host controller
In-Reply-To: <20140414171300.GL12916@arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <20140403220713.GA23545@google.com> <20140414171300.GL12916@arm.com>
Message-ID: <21141977.8ucQJzlJts@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 April 2014 18:13:00 Will Deacon wrote:
> Arnd: Is there anything more you'd like me to do with this series? Given
> that it would be targetting 3.16, there's still plenty of time to make
> changes (we talked about extracting some library functions in the past).

I don't remember the latest status of your patch set, but you might want
to read the discussions we had about Liviu's patches last week.

We still haven't figured out exactly how to handle I/O space in the common
code, but I think we are making progress.

We also have discussed some ideas about how to restructure the PCI
code layer to make it easier to share host drivers across architectures
and clean up the interfaces in the process.

	Arnd
