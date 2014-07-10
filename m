From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 10 Jul 2014 18:15:59 +0200
Subject: [alsa-devel] [PATCH V3 2/2] ASoC: samsung: Add machine driver for
 Odroid X2/U3
In-Reply-To: <CAD8Lp44JFtbcD22c+0PVb5S4U1kVTTxHD=PgqiKzhVypFW5Prg@mail.gmail.com>
References: <1404479625-25385-1-git-send-email-s.nawrocki@samsung.com>
 <1404479625-25385-2-git-send-email-s.nawrocki@samsung.com>
 <CAD8Lp44JFtbcD22c+0PVb5S4U1kVTTxHD=PgqiKzhVypFW5Prg@mail.gmail.com>
Message-ID: <53BEBC3F.6030205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 08/07/14 11:15, Daniel Drake wrote:
> Testing on ODROID-U2, v3 is not quite working for me, but v2 of the
> patch was fine.
> I boot up, run:
> # speaker-test -c 2 -t wav
> 
> As soon as I hear the word "front" I press ctrl+c and then run the
> command again.
> Now the command hangs with no audible output.
> 
> Any ideas? Let me know if you have trouble reproducing.

I just posted a patch addressing this, please let me know
if there are any further issues.

-- 
Thanks,
Sylwester
