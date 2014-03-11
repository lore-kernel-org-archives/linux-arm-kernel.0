From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Mar 2014 08:28:40 -0300
Subject: [PATCH 1/7] ARM: dts: mx25: Fix compatible string for generic USB
 PHY
In-Reply-To: <20140311075238.4bc0bea2@e6520eb>
References: <1394484885-21262-1-git-send-email-festevam@gmail.com>
 <20140311075238.4bc0bea2@e6520eb>
Message-ID: <CAOMZO5D0+28_Omq+k1=XwJdRbvpGFguShYYKQ6dEvgqvF6UyYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue, Mar 11, 2014 at 3:52 AM, Eric B?nard <eric@eukrea.com> wrote:

> why don't you use Denis' patches instead of copying them with you as
> the author ?

Some reasons:

1. The v1 version of the patches is not functional on mx25 due to the
wrong clock
2. It is better to separate ARM patches from USB patches as they go
through different maintainers
3. In the original patch 4/9 Denis has put me in the From field, so I
am not 'copying them with me as the author'
4. It is better to make one change per patch rather than mixing
different fixes into a single patch.

Anyway I am happy whethever version is applied by the maintainers.
Just wanted to get USB functional on mx25 ;-)

Regards,

Fabio Estevam
