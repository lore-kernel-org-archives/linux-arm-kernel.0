From: daniel@ffwll.ch (Daniel Vetter)
Date: Thu, 23 Aug 2018 08:16:47 +0200
Subject: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
In-Reply-To: <20180822201226.GB22148@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812195536.GA29811@ravnborg.org>
 <264d51a0-7e41-6c27-d438-9ae337e6dcf0@microchip.com>
 <20180814084112.GE21634@phenom.ffwll.local>
 <20180822201226.GB22148@ravnborg.org>
Message-ID: <CAKMK7uFC-gmJQqJnDBNYJi0KXQ2=z9ukz2E+eQuSC2W+3QXRTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2018 at 10:12 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Daniel.
>
>> > > Based on the above, would it be possible to utilise some
>> > > of these features without any dedicated userspace (mesa) support?
>> > > Any other driver that has something similar that can be used
>> > > for inspiration?
>> >
>> > This is really an interesting question indeed.
>>
>> Needs userspace like everything else. There's unfortunately no real
>> standard for 2d apis in userspace, which means none of these efforts go
>> very far. Mostly it's just some custom-made X drivers.
>>
>> Adding a generic 2d api to drm is a FAQ, and the answer is "no".
>
> And then you went off writing a blog post about it - thanks.
> The blog post provided a lot of useful answers - great.

Yeah I figured more detail than this here would be good, but also
wanted to avoid having to retype that ever again.

> (Or rather you will write the blog in 5 days, seems to be some time
>  machine involved. (Date is the 27th below the title)).

My blog platform pulled one on me - pushed it out with a future date,
with the idea to proof-read a bit more. Didn't work, so everyone read
the slightly draft-ish version :-/ In the past this did work, and was
very neat.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
