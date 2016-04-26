From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Apr 2016 16:03:19 +0100
Subject: [PATCH 10/18] ASoC: sti: Update example to include
 assigned-clocks and mclk-fs
In-Reply-To: <20160426145129.GA11946@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-11-git-send-email-peter.griffin@linaro.org>
 <20160421154933.GR3217@sirena.org.uk>
 <20160426115210.GB5457@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160426142357.GW3217@sirena.org.uk>
 <20160426145129.GA11946@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20160426150319.GY3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 03:51:29PM +0100, Peter Griffin wrote:
> On Tue, 26 Apr 2016, Mark Brown wrote:
> > On Tue, Apr 26, 2016 at 12:52:10PM +0100, Peter Griffin wrote:

> > If there are never going to be any new users why bother at all, why
> > would anyone paste it in when all the SoCs that ever use this are
> > already upstream?

> Generally if I come across documentation which is incorrect, I like to fix it.

A lot of this is details of the system integration for this SoC, not
actual errors.

> Currently the DT ASoC documentation doesn't match the driver and the example
> doesn't work, which is not ideal. I could well be the last person who needs
> to read it & use the example, but deliberately leaving it with mistakes in
> seemed like a bad idea.

People might end up trying to use it as an example, it's fairly routine
to have to explain to people that just because some old driver did
something that doesn't mean it's something we want in new drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160426/7531f543/attachment.sig>
