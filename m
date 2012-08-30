From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 30 Aug 2012 16:03:23 -0700
Subject: [PATCH 8/8] input: ab8500-ponkey: Rely on MFD core to convert
 IRQs to virtual
In-Reply-To: <20120830230221.GD21501@core.coreip.homeip.net>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-9-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ-HOGy_sdsCQSNOdYTDzHFszk0OySM88TjO-neSJUz0A@mail.gmail.com>
 <20120821092328.GC26899@gmail.com>
 <20120821164244.GA4672@core.coreip.homeip.net>
 <20120830131202.GG14145@gmail.com>
 <20120830230221.GD21501@core.coreip.homeip.net>
Message-ID: <20120830230323.GE21501@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 04:02:21PM -0700, Dmitry Torokhov wrote:
> On Thu, Aug 30, 2012 at 02:12:04PM +0100, Lee Jones wrote:
> > > Sorry for the delay. Yes, this shoudl be fine, but since it is
> > > essentially a revert of the original patch it should be pushed in as
> > > such.
> > 
> > How's this?
> > 
> 
> Excellent.

I assume you will be merging it with the rest of AB8500 patches, right?

-- 
Dmitry
