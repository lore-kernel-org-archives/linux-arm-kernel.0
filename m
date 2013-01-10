From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 Jan 2013 10:21:43 +0000
Subject: [PATCH 1/4] arm: vt8500: Add support for Wondermedia WM8750/WM8850
In-Reply-To: <1357783407.28830.2.camel@gitbox>
References: <1356650452-16559-1-git-send-email-linux@prisktech.co.nz>
 <201301092127.05804.arnd@arndb.de> <1357783407.28830.2.camel@gitbox>
Message-ID: <201301101021.44238.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 January 2013, Tony Prisk wrote:
> On Wed, 2013-01-09 at 21:27 +0000, Arnd Bergmann wrote:
> > 
> > > Should patches in pull-requests have Ack'd lines already?
> 
> This is what I thought - and the reason I haven't sent a pull-request
> for the patch's - I haven't had any Ack's :)
> 

Sorry, I think I misunderstood the question then. I meant that if
you received an Acked-by statement, it should be part of the
changeset comment by the time you send a pull request.

There is also the rule that patches need to be reviewed on the
mailing list before you submit them for inclusion. Like all
rules, this can be bent a little for patches that are obvious
correct bug fixes, especially when you are the platform
maintainer. What you can do here is send the patches out to the
mailing list without any additional Acks and send the pull
request as the [PATCH 0/X] mail. We can then look at the
patches if necessary or just pull in the branch straight away.

	Arnd
