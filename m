From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 10:45:18 -0700
Subject: [GIT PULL] at91: cleanup for 4.1 #3
In-Reply-To: <1426524126-29068-1-git-send-email-nicolas.ferre@atmel.com>
References: <1426524126-29068-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20150403174518.GA23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 05:42:06PM +0100, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This batch deals with the at91rm9200 System Timer. It is a complete re-work by
> Alexandre to make it use modern kernel infrastructure and move its features to
> proper drivers. I stacked it on top of cleanup to lower the risk of conflict
> and above all to be sure that it'll be merged before multi-platform. And you
> know... well, it's the last step needed before switching to multi-platform!
> 
> Thanks, best regards,
> 
> The following changes since commit 598e085590fc5ac1fecff00e842a8a6c2ae010e5:
> 
>   ARM: at91: remove old setup (2015-03-13 18:01:10 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup3
> 
> for you to fetch changes up to 8590ca655a19f9e124b52bfbf28f14eb16a05bec:
> 
>   ARM: at91: remove useless include (2015-03-16 17:03:08 +0100)

Merged. Turns out we had this as part of the multiplatform branch I had already
merged, but I also brought this in under next/drivers.


-Olof
