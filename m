From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 09 May 2012 21:55:23 +0900
Subject: [PATCH 00/33] Use common macro to define resources
In-Reply-To: <20120425113521.GW24211@n2100.arm.linux.org.uk>
References: <1335327163-11794-1-git-send-email-tushar.behera@linaro.org>
 <201204250938.58397.heiko@sntech.de> <20120425101007.GM9142@game.jcrosoft.org>
 <201204251121.47358.arnd@arndb.de>
 <20120425113521.GW24211@n2100.arm.linux.org.uk>
Message-ID: <01b201cd2de2$ffa5d7d0$fef18770$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Wed, Apr 25, 2012 at 11:21:47AM +0000, Arnd Bergmann wrote:
> > Note that the point of the DEFINE_RES_*() macros is really to prevent
> > people from coming up with new silly macros to do the same thing, as
> > we've had in the past.
> 
> One of the other reaons was to stop the stream of resources with wrong
> endings (because people kept thinking it was exclusive rather than
> inclusive) - and the resulting stream of additional patches to fix those
> errors.
> 
> The legacy platforms do have those kinds of errors - when I converted
> SA11x0 as part of a previous patch set, I found a number suffering from
> this error.  (Were any found in this patch set?  I've not read through
> it.)
> 
> I think if this becomes a small %age of the change to Samsung stuff,
> and Kukjin is happy with it, it should go in.

Yes, agree. I will apply this whole series.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
