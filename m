From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Oct 2013 20:43:49 +0200
Subject: [PATCH] unset twsi option3 for gconfig as well
In-Reply-To: <20131014091230.65047d00@skate>
References: <1381706847-32762-1-git-send-email-roel.kluin@gmail.com>
 <CACRpkdb8ibOm61D_iGkOkbas1475n4k5jptnRH7VFk=9+pipHQ@mail.gmail.com>
 <20131014091230.65047d00@skate>
Message-ID: <525C3B65.30501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2013 09:12 AM, Thomas Petazzoni wrote:
> On Mon, 14 Oct 2013 09:08:11 +0200, Linus Walleij wrote:
>> Please include Thomas & Sebastian on the To: line when posting
>> patches to this driver.
>
> ... and you should quote the entire e-mail so it's easier for us to see
> what it is all about :-))
>
> Sebastian, the original e-mail is at
> http://www.spinics.net/lists/kernel/msg1618853.html.
>
> Since this is a Dove-specific pinctrl issue, and Sebastian is the one
> knowing about Dove, I'll let him answer.

Roel,

thanks for the typo catch! Next time please always describe what and
why your patches are doing. No matter how simple the fix is. Also,
try to narrow down Cc recipients, e.g. Grant, Rob, and devtree ML
love to not getting bugged with this.
(removed them from Cc, added LAKML)

@Linus:
I guess the typo is there from the beginning. You know a good way to
determine how far it should go back to -stable?

Please apply with following commit msg (or request a proper v2):

"""
This fixes a typo which left twsi config3 option enabled.
"""

and

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Sebastian
