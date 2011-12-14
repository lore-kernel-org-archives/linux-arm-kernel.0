From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Dec 2011 14:00:05 -0800
Subject: [PATCH] ARM: davinci: add missing commas on last members of
 structure and arrays
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B604811D@DBDE01.ent.ti.com>
References: <1323335151-25398-1-git-send-email-akshay.s@ti.com>
 <DF0F476B391FA8409C78302C7BA518B604811D@DBDE01.ent.ti.com>
Message-ID: <20111214220005.GQ32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nori, Sekhar <nsekhar@ti.com> [111214 04:42]:
> Hi Akshay,
> 
> On Thu, Dec 08, 2011 at 14:35:51, Shankarmurthy, Akshay wrote:
> > This patch adds missing commas on last members of structure and arrays.
> > This makes less harder to add additional initializer at the end of the
> > existing initializers and avoids the conflict of more line being
> > modified. This was pointed out by Russell King in his pet peeves mail at
> > http://www.spinics.net/lists/arm-kernel/msg147268.html.
> 
> Tony has already provided link to his patches fixing this in the
> message you referenced. Is your patch catching any additional instances?
> 
> Tony's patch adds comma after some sentinels, which should be dropped.

My patches are intended just as a reference, please feel free
to pick from those and apply as needed along with other
related clean-up.

Regards,

Tony
