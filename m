From: timur@tabi.org (Timur Tabi)
Date: Wed, 29 May 2013 10:41:58 -0500
Subject: [PATCH v6 01/10] ASoC: phycore-ac97: Add DT support
In-Reply-To: <20130529135342.GB29528@S2101-09.ap.freescale.net>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
 <1369752478-30260-2-git-send-email-mpa@pengutronix.de>
 <20130529135342.GB29528@S2101-09.ap.freescale.net>
Message-ID: <CAOZdJXVL2uP-qW=kydgS-t3C=C+6Cn9D3FWqbMuoK2c-EnckyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 8:53 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>
>
> This function is unavailable until patch #7, right?


May I suggest that Markus run this script:

for i in 1 2 3 4 5 6 7 8 9
do
  git checkout HEAD^
  make
done

It's important that each commit in a patchset be compilable, otherwise
git-bisect will break.
