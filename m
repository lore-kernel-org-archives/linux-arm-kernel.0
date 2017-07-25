From: smitha.t@samsung.com (Smitha T Murthy)
Date: Tue, 25 Jul 2017 10:23:13 +0530
Subject: [Patch v5 12/12] Documention: v4l: Documentation for HEVC CIDs
In-Reply-To: <54ad8901-ccd0-4b0b-bb3f-23779d3534e8@linaro.org>
References: <1497849055-26583-1-git-send-email-smitha.t@samsung.com>
 <CGME20170619052521epcas5p36a0bc384d10809dcfe775e6da87ed37b@epcas5p3.samsung.com>
 <1497849055-26583-13-git-send-email-smitha.t@samsung.com>
 <617cb1c5-074c-3f47-0096-fe7568dab8be@linaro.org>
 <1500290336.16819.6.camel@smitha-fedora>
 <54ad8901-ccd0-4b0b-bb3f-23779d3534e8@linaro.org>
Message-ID: <1500958393.16819.3282.camel@smitha-fedora>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-07-20 at 18:46 +0300, Stanimir Varbanov wrote:
> Hi,
> 
> >>> +
> >>> +    * - ``V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN``
> >>> +      - Main profile.
> >>
> >> MAIN10?
> >>
> > No just MAIN.
> 
> I haven't because the MFC does not supported it?
> 
> If so, I think we have to add MAIN10 for completeness and because other
> drivers could have support for it.
> 
MFC supports Main and Main Still profile for encoder. Main, Main10, Main
Still for decoder. I will add both Main and Main10 in the next patch
series.
Thank you for the review.

Regards,
Smitha
