From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 25 Mar 2013 17:57:42 -0400 (EDT)
Subject: [PATCH 07/15] ARM: cpuidle: add init/exit routine
In-Reply-To: <5150C74E.1040903@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org>
 <20130325181038.GA631@lunn.ch> <51509873.1010408@linaro.org>
 <alpine.LFD.2.03.1303251616070.1372@syhkavp.arg>
 <5150C74E.1040903@linaro.org>
Message-ID: <alpine.LFD.2.03.1303251756000.1372@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Mar 2013, Daniel Lezcano wrote:

> On 03/25/2013 09:28 PM, Nicolas Pitre wrote:
> > On Mon, 25 Mar 2013, Daniel Lezcano wrote:
> > 
> >> In the future, when all the ARM cpuidle driver will be fully
> >> consolidated, that will be easier to identify the common parts across
> >> the different arch and then move them to the generic framework.
> > 
> > Nothing prevents you from doing that consolidation work right in 
> > drivers/cpuidle/.
> 
> I fully agree with you but I think there is a misunderstanding.
> 
> The idea is to consolidate the ARM code in the ARM cpuidle driver which
> is mostly empty. The init/exit functions could falsely lead someone to
> think they could be moved in the generic framework but IMO it is too
> soon because the code consolidation will bring some arch specificity and
> in this case we will going back and forth. I want to avoid that.
> 
> Let me consolidate the ARM driver, cleanup the headers to split the arch
> specific code from the rest and then move this driver to
> drivers/cpuidle. This is just a question of a week.

OK.


Nicolas
