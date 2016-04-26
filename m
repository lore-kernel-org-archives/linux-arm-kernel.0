From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 26 Apr 2016 15:51:29 +0100
Subject: [PATCH 10/18] ASoC: sti: Update example to include
 assigned-clocks and mclk-fs
In-Reply-To: <20160426142357.GW3217@sirena.org.uk>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-11-git-send-email-peter.griffin@linaro.org>
 <20160421154933.GR3217@sirena.org.uk>
 <20160426115210.GB5457@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160426142357.GW3217@sirena.org.uk>
Message-ID: <20160426145129.GA11946@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 26 Apr 2016, Mark Brown wrote:

> On Tue, Apr 26, 2016 at 12:52:10PM +0100, Peter Griffin wrote:
> > On Thu, 21 Apr 2016, Mark Brown wrote:
> 
> > > This one is more relevant though I'm still a bit concerned that there's
> > > an expectation that the examples can just be pasted in...
> 
> > So although I would only consider copying an example as the starting
> > point for getting something working (and indeed it was the case here). On STi
> > arch there *should* be a very high probability that copying the exanple 
> > is all that will be required.
> 
> If there are never going to be any new users why bother at all, why
> would anyone paste it in when all the SoCs that ever use this are
> already upstream?

Generally if I come across documentation which is incorrect, I like to fix it.

Currently the DT ASoC documentation doesn't match the driver and the example
doesn't work, which is not ideal. I could well be the last person who needs
to read it & use the example, but deliberately leaving it with mistakes in
seemed like a bad idea.

Peter. 
