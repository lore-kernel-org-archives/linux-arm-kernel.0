From: dianders@chromium.org (Doug Anderson)
Date: Tue, 7 Oct 2014 10:11:54 -0700
Subject: [PATCH 0/2] init some clock rate from dts for rk3288
In-Reply-To: <1412674438-26160-1-git-send-email-kever.yang@rock-chips.com>
References: <1412674438-26160-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=URpegr4xZ8fVf4AmKYWg2_UtS-nsQibuaXddio3xMNig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Tue, Oct 7, 2014 at 2:33 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
> This patch add init rate for PLLs and some bus clock  from dts for rk3288,
> add two clock rate of 400M and 500M into rate table for we will use it.

In the cover letter you should probably mention that your series won't
work properly unless <https://patchwork.kernel.org/patch/5038781/> is
applied.  When I don't have that patch then "aclk_cpu" doesn't get set
properly.
