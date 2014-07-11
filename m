From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 11 Jul 2014 21:28:45 +0200
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <20140618211038.GD558@drone.musicnaut.iki.fi>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <CAL_JsqKw-C6uZBU3hccGmdofXcCcUKTV6z7Af6KwYwnZiy3HoQ@mail.gmail.com>
 <201406182122.29623@pali>
 <20140618211038.GD558@drone.musicnaut.iki.fi>
Message-ID: <20140711192845.GB20015@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2014-06-19 00:10:39, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Jun 18, 2014 at 09:22:29PM +0200, Pali Roh?r wrote:
> > So without this patch DT migration for Nokia N900 cannot be done 
> > without breaking userspace - which is not acceptable...
> 
> I guess the fact is that the Nokia N900 proprietary userspace has
> never worked properly with the mainline kernel without severe patching,
> so you cannot really talk about any regression. If you cannot fix
> those programs, you could still probably emulate the old Nokia kernel's
> /proc/cpuinfo by providing some text file and bind mounting it, no?

Actually, yes, it worked pretty well with some close-to-mainline
kernels.

And bind-mount on /proc/cpuinfo is beyond ugly, don't you think?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
