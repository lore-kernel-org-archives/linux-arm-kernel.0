From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Jun 2017 00:22:40 +0800
Subject: [PATCH v2 3/3] pwm: sun4i: drop legacy callbacks
In-Reply-To: <20170530193209.19247-4-alexandre.belloni@free-electrons.com>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
 <20170530193209.19247-4-alexandre.belloni@free-electrons.com>
Message-ID: <CAGb2v64sL=uJtLmtEeGcbAMrgsEmKDsca0f2+HfDS18jZeMjqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 31, 2017 at 3:32 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Remove the legacy callbacks .enable(), .disable(), .set_polarity() and
> .config().
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

FWIW,

Acked-by: Chen-Yu Tsai <wens@csie.org>
