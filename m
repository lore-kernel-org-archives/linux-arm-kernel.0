From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 8 Sep 2018 15:15:18 +0100
Subject: [PATCH v2 3/3] arm64: dts: qcom: pm8998: Add die temperature
 channel node to the ADC
In-Reply-To: <20180906212206.GE22824@google.com>
References: <20180906210454.247219-1-mka@chromium.org>
 <20180906210454.247219-4-mka@chromium.org>
 <CAD=FV=WLcgKQWAp8HnBFZhZ4+32keMANcYJ+nGquePqsOnjJ7A@mail.gmail.com>
 <20180906212206.GE22824@google.com>
Message-ID: <20180908151518.1a235bff@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Sep 2018 14:22:06 -0700
Matthias Kaehlcke <mka@chromium.org> wrote:

> On Thu, Sep 06, 2018 at 02:10:43PM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Thu, Sep 6, 2018 at 2:04 PM, Matthias Kaehlcke <mka@chromium.org> wrote:  
> > > Add a channel node for the die temperature to the ADC.
> > >
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>  
> > 
> > Double-SoB?  
> 
> I must have run 'amend' with '-s' out of habit, which wasn't the right
> thing to do in this case :/
> 
> > ...presumably Andy can remove that when he lands and doesn't need a re-post...  
> 
> Andy, in case you need me to repost let me know.
Slightly worse than that (as was patch 1).  You accidentally used
-- rather than --- to separate the change log.  So I ended up with

Signed-off-by: M..
Reviewed-by: ..
Signed-off-by: M..
--
Changelog

Signed-off-by: J....

Good think the double signed off was raised as chances are I wouldn't
have notice it.

Jonathan
> 
> Thanks
> 
> Matthias
