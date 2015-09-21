From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 21 Sep 2015 20:45:03 +0530
Subject: [PATCH v2] ARM: pxa: ssp: Fix build error by removing originally
 incorrect DT binding
In-Reply-To: <87fv28qh49.fsf@belgarion.home>
References: <1441610581-11434-1-git-send-email-jarkko.nikula@linux.intel.com>
 <87zj0rsqhe.fsf@belgarion.home> <55FFB643.1080208@linux.intel.com>
 <87fv28qh49.fsf@belgarion.home>
Message-ID: <20150921151503.GK2381@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 11:03:18AM +0200, Robert Jarzmik wrote:
> Jarkko Nikula <jarkko.nikula@linux.intel.com> writes:
> 
> > Hi
> >
> > On 09/12/2015 04:43 PM, Robert Jarzmik wrote:
> >> Jarkko Nikula <jarkko.nikula@linux.intel.com> writes:
> >>
> >>> Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
> >>> build error here because it removed the type LPSS_SSP and I didn't notice
> >>> the type was used here too.
> >> Queued into pxa/fixes, thanks.
> >>
> > Gentle reminder, is this going to 4.3-rc3?
> It is going into v4.3.
> 
> Now knowing if it is v4.3-rc3 is another story, as currently the pxa platform is
> broken because of a dmaengine regression. And if the necessary fix is not
> applied through dmaengine tree (by lack of time from Vinod), I'll want to carry
> it through my tree, which is the reason why I have not made the pull request
> yet.

Which ones are required for fixing, I will priortize those...

-- 
~Vinod
