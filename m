From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Thu, 19 Jun 2014 00:10:39 +0300
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <201406182122.29623@pali>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <CAL_JsqKw-C6uZBU3hccGmdofXcCcUKTV6z7Af6KwYwnZiy3HoQ@mail.gmail.com>
 <201406182122.29623@pali>
Message-ID: <20140618211038.GD558@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 18, 2014 at 09:22:29PM +0200, Pali Roh?r wrote:
> So without this patch DT migration for Nokia N900 cannot be done 
> without breaking userspace - which is not acceptable...

I guess the fact is that the Nokia N900 proprietary userspace has
never worked properly with the mainline kernel without severe patching,
so you cannot really talk about any regression. If you cannot fix
those programs, you could still probably emulate the old Nokia kernel's
/proc/cpuinfo by providing some text file and bind mounting it, no?

A.
