From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 18:25:11 +0200
Subject: [PATCH, RFC 22/22] radio-si4713: depend on SND_SOC
In-Reply-To: <CAC-25o9Xp+pu_AUwxyh+YsiOCOebzMRF37v1VWZJD6nrbx5e6Q@mail.gmail.com>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-23-git-send-email-arnd@arndb.de>
 <CAC-25o9Xp+pu_AUwxyh+YsiOCOebzMRF37v1VWZJD6nrbx5e6Q@mail.gmail.com>
Message-ID: <201305021825.12094.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, edubezval at gmail.com wrote:
> On Thu, May 2, 2013 at 11:16 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > It is not possible to select SND_SOC_SI476X if we have not also
> > enabled SND_SOC.
> >
> > warning: (RADIO_SI476X) selects SND_SOC_SI476X which has unmet
> >          direct dependencies (SOUND && !M68K && !UML && SND && SND_SOC)
> >
> > Cc: Hans Verkuil <hverkuil@xs4all.nl>
> > Cc: linux-media at vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> 
> Note on your patch title, this change is against si476X, not on *si4713*.
> 

Sorry about that, I must have copied the wrong prefix from an older patch
then. I'll fix it up locally in case I need to resend.

	Arnd
