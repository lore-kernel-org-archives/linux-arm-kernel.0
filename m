From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 6 Mar 2012 18:38:44 +0100
Subject: [PATCH] ARM: remove ixp2000 platform
In-Reply-To: <201203061710.54171.arnd@arndb.de>
References: <1330450426-14639-1-git-send-email-robherring2@gmail.com>
 <201203061412.00073.arnd@arndb.de>
 <alpine.LFD.2.02.1203061146210.31242@xanadu.home>
 <201203061710.54171.arnd@arndb.de>
Message-ID: <20120306173844.GC3005@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 05:10:53PM +0000, Arnd Bergmann wrote:
> On Tuesday 06 March 2012, Nicolas Pitre wrote:
> > The NSLU2 is (was) a quite popular NAS device and it is used in big 
> > endian by default.
> > 
> > The BE support isn't getting in the way of anything, so there is no 
> > reason to remove it, even if it isn't being used much.
> 
> Ok, that's what I thought, just making sure. If it was completely
> dead code, things would be different.

Obligatory Monty Python quote:

    "I'm not dead."
    "'Ere, he says he's not dead."
    "Yes he is."

Even though Intel dropped the IXP like a hot potato, people are still
actively using Linux on it, and in big endian mode.

Thanks,
Richard
