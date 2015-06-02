From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 2 Jun 2015 10:56:54 -0700
Subject: [PATCH 0/6] Support CPR on MSM8916
In-Reply-To: <20150602105328.GJ14071@sirena.org.uk>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
 <20150602105328.GJ14071@sirena.org.uk>
Message-ID: <20150602175654.GA24349@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02, Mark Brown wrote:
> On Mon, Jun 01, 2015 at 06:47:53PM -0700, Stephen Boyd wrote:
> 
> > Stephen Boyd (6):
> >   regulator: core: Don't spew backtraces on duplicate sysfs
> >   regulator: core: Print at debug level on debugfs creation failure
> 
> These two patches don't seem to be tied to the rest of the series at all
> (they certainly trigger already for some systems).


The series causes these warning to trigger on devices with CPR
and these patches silence them. So it is related, but the patches
aren't necessary for compilation. They should go through the
regulator tree, if that's what you're asking.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
