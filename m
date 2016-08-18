From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 18 Aug 2016 10:55:33 -0400
Subject: Merging code with arch condition into head.S
In-Reply-To: <20160818144413.GB13458@lunn.ch>
References: <CACna6rxhhD5kfa1oJzqp2dQxBhjaUzdTkNPMcm-+iNvQHD8yzA@mail.gmail.com>
 <CAKv+Gu8dP8oAq-ykejskw+AzX-7_h_Ws6sFdXO+40MiGM14ccA@mail.gmail.com>
 <CACna6rw1eTiqijo24SiGAYi_XeEGWb-C1L5diYUzpyA3o7e+qw@mail.gmail.com>
 <20160818134722.GA13458@lunn.ch>
 <CACna6rwOXMEwJ=OjovpZgFHTAR3wrwAdQrgtxFzDYRPKypoSeg@mail.gmail.com>
 <20160818144413.GB13458@lunn.ch>
Message-ID: <CDD72BA1-E050-4EF8-99E7-1B6FC5452F55@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Aug 18, 2016, at 10:44, Andrew Lunn <andrew@lunn.ch> wrote:

>> I think I'll stick to the modified (out of tree) kernel for now, maybe
>> in a long term this intermediate loader could be a good idea. Did you
>> ever see solution like this? I never wrote my own loaders, so it'd
>> take me quite some time to learn required things.
> 
> Things might of moved on since then, but try Jason Cooper and the
> Impedance Matcher.

Search for pxa-impedance-matcher on github. I think under zonque?  That's Daniel Mack. He wrote it. It was Nico's suggestion, though. I just expanded it to some mvebu boards. 

hth,

Jason.

Sorry for hacked up email, I'm on the road atm. 
