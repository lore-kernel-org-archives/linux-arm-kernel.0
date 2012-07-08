From: airlied@gmail.com (Dave Airlie)
Date: Sun, 8 Jul 2012 08:35:55 +0100
Subject: [PATCH, RFC] i.MX DRM support
In-Reply-To: <20120706225833.GA22265@kroah.com>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
 <20120702100506.GI24458@pengutronix.de>
 <20120706225833.GA22265@kroah.com>
Message-ID: <CAPM=9ty6xqMg+X7UJMtLShPv5=2kC3PXeBrfLwXT8ReKN+q-9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2012 at 11:58 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Jul 02, 2012 at 12:05:06PM +0200, Sascha Hauer wrote:
>> On Thu, Jun 14, 2012 at 03:43:22PM +0200, Sascha Hauer wrote:
>> > Hi All,
>> >
>> > The following is the state-of-the-art i.MX IPU (Image Processing Unit)
>> > DRM support.
>> >
>> > This code is around for quite some time now and has been posted several
>> > times with different APIs, first with plain old framebuffer support, now
>> > DRM, first platform device binding, now devicetree. Unfortunately there's
>> > quite much code needed to get something useful out of the IPU, so these
>> > patches haven't received a lot of attention from people not involved in
>> > i.MX. I think we have now come to a point where this code needs more public
>> > exposure and where it's easier to talk in incremental changes instead of
>> > blobs. Therefore I request this to go to staging for some cycles.
>>
>> Dave, Greg,
>>
>> Comments to this one? I addressed the comments I received so far and am
>> about to respin this series. Is it ok to put this to staging? If yes,
>> should I move the whole stuff into drivers/staging/ or should it stay
>> in drivers/gpu/drm with just a Kconfig dependency on STAGING?
>
> That's up to the DRM subsystem maintainer to choose.

Sorry guys been out of the loop on arm drivers due to other things,
but probably should go in staging proper for now, until I can at least
spend time reviewing it.

Dave.
