From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Apr 2014 20:52:25 +0200
Subject: The Alphabet (or, the sorting of Kconfig symbols)
In-Reply-To: <CACxGe6uoB6CkuV7HCg8wdyu2Tm471YaAz0sDA3W2C0MPAYYY+Q@mail.gmail.com>
References: <20140404111647.GZ7528@n2100.arm.linux.org.uk>
 <CACxGe6uoB6CkuV7HCg8wdyu2Tm471YaAz0sDA3W2C0MPAYYY+Q@mail.gmail.com>
Message-ID: <20140408185225.GU29751@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 04, 2014 at 04:24:27AM -0700, Grant Likely wrote:
> On Fri, Apr 4, 2014 at 4:16 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > For those who don't know it, the order of letters in the alphabet is:
> >
> > A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
> >
> > and we use this order to determine the position of "select" entries in
> > Kconfig files.  We do that so that we can reduce conflicts.  Conflicts
> > such as these kinds of rubbish:
> 
> Equally applies to #include ordering.
With #includes there might be exceptions though because of dependencies
between headers.
I don't know how common these are today, I didn't have had dependency
problems for some time now, but I wouldn't want checkpatch to treat the
order of #includes as error, while for Kconfig it's fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
