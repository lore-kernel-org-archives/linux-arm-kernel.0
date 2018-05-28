From: tfiga@chromium.org (Tomasz Figa)
Date: Mon, 28 May 2018 21:21:48 +0900
Subject: [PATCH] media: v4l2-ctrl: Add control for VP9 profile
In-Reply-To: <a618b1b5-48ac-f725-39a6-50ba81b167f0@xs4all.nl>
References: <20180517095349.203865-1-keiichiw@chromium.org>
 <a618b1b5-48ac-f725-39a6-50ba81b167f0@xs4all.nl>
Message-ID: <CAAFQd5AR=At5n=_ZyB_LM8cV6Mw5H5cqBqAH7-b6JUeE0b8Q9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Fri, May 25, 2018 at 6:09 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:

> On 17/05/18 11:53, Keiichi Watanabe wrote:
> > Add a new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE for selecting desired
> > profile for VP9 encoder and querying for supported profiles by VP9
encoder
> > or decoder.
> >
> > An existing control V4L2_CID_MPEG_VIDEO_VPX_PROFILE cannot be
> > used for querying since it is not a menu control but an integer
> > control, which cannot return an arbitrary set of supported profiles.
> >
> > The new control V4L2_CID_MPEG_VIDEO_VP9_PROFILE is a menu control as
> > with controls for other codec profiles. (e.g. H264)

> I don't mind adding this control (although I would like to have an Ack
from
> Sylwester), but we also need this to be used in an actual kernel driver.

> Otherwise we're adding a control that nobody uses.

Indeed. We were supposed to also include a patch for mtk-vcodec driver, but
somehow it went MIA. Keiichi will add it in next revision. Thanks for
giving this a look.

Best regards,
Tomasz
