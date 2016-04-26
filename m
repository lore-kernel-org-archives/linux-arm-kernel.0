From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 26 Apr 2016 18:49:13 +0100
Subject: [PATCH 10/18] ASoC: sti: Update example to include
 assigned-clocks and mclk-fs
In-Reply-To: <20160426164104.GC3217@sirena.org.uk>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-11-git-send-email-peter.griffin@linaro.org>
 <20160421154933.GR3217@sirena.org.uk>
 <20160426115210.GB5457@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160426142357.GW3217@sirena.org.uk>
 <20160426145129.GA11946@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160426150319.GY3217@sirena.org.uk>
 <20160426161432.GA12088@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160426164104.GC3217@sirena.org.uk>
Message-ID: <20160426174913.GA12621@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 26 Apr 2016, Mark Brown wrote:

> On Tue, Apr 26, 2016 at 05:14:32PM +0100, Peter Griffin wrote:
> > On Tue, 26 Apr 2016, Mark Brown wrote:
> 
> > > A lot of this is details of the system integration for this SoC, not
> > > actual errors.
> 
> > This particular clock patch yes, but the other ASoC dt doc update is fixing
> > bindings which haven't progressed in lockstep with the driver code. Presumably
> > this happened during the review process when they were changed to being st,
> > prefixed in the driver, but the doc wasn't also updated.
> 
> The bits where you are correcting the names of the properties are not
> details of the system integration and are therefore fine.  The bits
> where you're documenting the particular clocking arrangements for the
> SoC you happen to be using less so.

Ok sounds good. With that in mind I will drop this clocking patch in v4
and just leave the one which updates the ASoC bindings mismatch.

> 
> > > it's fairly routine
> > > to have to explain to people that just because some old driver did
> > > something that doesn't mean it's something we want in new drivers.
> 
> > I'm sure it is. Although I fail to see why leaving the documentation with
> > mistakes in is helpful to anybody.
> 
> Fixing actual mistakes is fine.

Peter.
