From: groeck@google.com (Guenter Roeck)
Date: Fri, 15 Jun 2018 06:01:28 -0700
Subject: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
In-Reply-To: <9c80de4e-c070-1051-2089-2d53826c6fc7@xs4all.nl>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com>
 <9c80de4e-c070-1051-2089-2d53826c6fc7@xs4all.nl>
Message-ID: <CABXOdTdrXiseyjS_aWwbiAWW9F4gcQbRsK-KCkUVub82dBtZvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 5:00 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 13/06/18 16:07, Maxime Ripard wrote:
> > From: Pawel Osciak <posciak@chromium.org>
>
> Obviously this needs a proper commit message.
>
> >
> > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > Reviewed-by: Wu-cheng Li <wuchengli@chromium.org>
> > Tested-by: Tomasz Figa <tfiga@chromium.org>
> > [rebase44(groeck): include linux/types.h in v4l2-controls.h]

That internal note should go away.

Guenter
