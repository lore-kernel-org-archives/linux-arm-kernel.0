From: swetland@google.com (Brian Swetland)
Date: Wed, 3 Mar 2010 00:00:51 -0800
Subject: board/device file names, and machine names
In-Reply-To: <4B8DD937.40301@billgatliff.com>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
	<a55d774e1003021456id57a19eud4ca5752ba91d72d@mail.gmail.com>
	<4B8DD937.40301@billgatliff.com>
Message-ID: <a55d774e1003030000p470a8c42i2ffd890284f72b9e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 2, 2010 at 7:36 PM, Bill Gatliff <bgat@billgatliff.com> wrote:
> Brian Swetland wrote:
>> We would, of course, prefer to keep the board named mahimahi for all
>> the reasons that have been mentioned in various previous discussions
>> around trout, etc:
>
> Ooh, division in the camp. ?:)
>
> Actually, I'd like to change my previous answer. ?In the interest of
> getting code into kernel.org more quickly, I for one could live with
> "mahimahi"--- so long as a comment in board-mahimahi.c provided the
> "also-known-as" names. ?Same for board-halibut.c, etc.

halibut I'm happy to have Qualcomm rename -- the surf7201a is their
development platform after all.  The name was legacy from early days
before we were sure we could even refer to the board by its internal
name, etc.

Beyond all the other reasons I mentioned that we'd like to keep the
names for the projects that we wrote the code for (which includes some
devices manufactured by our friends at HTC, some of whom also
contributed kernel patches, thanks!), as we're trying to move this
code upstream we also have to maintain fully functional and working
trees internally (which we publish externally as well).

Avoiding disruptive renaming as stuff flows upstream makes it easier
for us to deal with the fact that we're not going to be able to drop all
our code in mainline all at once (much though that'd be convenient)
and to try to keep reducing the delta between our working branch(es)
and Linus's canonical linux kernel.

Brian
