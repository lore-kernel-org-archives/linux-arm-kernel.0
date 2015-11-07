From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Sat, 7 Nov 2015 14:40:40 +1100
Subject: [PATCH] Revert "ARM: dts: twl4030: Add iio properties for bci
 subnode"
In-Reply-To: <20151107024457.GA18676@earth>
References: <1446826430-3705-1-git-send-email-sre@kernel.org>
 <CAMAWPa-7_q8Sf+4VQ0EE6zU-NvacKERFgjqueNif=52Frn0enA@mail.gmail.com>
 <20151107091925.7dcd14a7@canb.auug.org.au>
 <20151107024457.GA18676@earth>
Message-ID: <20151107144040.2afa1228@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Sat, 7 Nov 2015 03:44:57 +0100 Sebastian Reichel <sre@kernel.org> wrote:
>
> Is there an easy way to check this, so that I can create a cronjob
> checkin it? Having an additional automatic "your tree differs from
> linux-next" would be helpful, since that would make me search for
> the problem/a mail from Stephen.

Well,

wget -q -O- http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/plain/Next/SHA1s | sed -n 's/^battery\t\t*//p'

will get you the SHA1 of the top of your branch that I merged into the
latest release.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
