From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 21 Mar 2011 09:12:31 +0200
Subject: [PATCH V2 1/2] mtd: nand: Allow NAND chip ids to be included
	standalone.
In-Reply-To: <4D86F295.8040409@codeaurora.org>
References: <1299542935-20291-1-git-send-email-mnalajal@codeaurora.org>
	<1299570622.2754.4.camel@localhost> <4D766A2F.9080001@codeaurora.org>
	<4D86F295.8040409@codeaurora.org>
Message-ID: <1300691551.2761.8.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-03-21 at 12:09 +0530, Murali Nalajala wrote:
> On 3/8/2011 11:11 PM, Murali Nalajala wrote:
> > On 3/8/2011 12:50 AM, Artem Bityutskiy wrote:
> >> On Tue, 2011-03-08 at 05:38 +0530, Murali Nalajala wrote:
> >>> Lets non-standard NAND drivers take advantage of known NAND
> >>> chip information.
> >>>
> >>> The initial development of msm nand driver, driver uses the supported
> >>> NAND devices information as a hardcoded table. Remove the existing
> >>> hardcoded supported flash device table and read the flash device
> >>> information from the flash id table which are part of the mtd subsystem.
> >>
> >> Why this initial version should be upstream? Why wouldn't you make it
> >> "standard" first?
> >>
> >
> > Currently we are not fully using the MTD nand subsystem. That's the
> > intention author has introduced "non-standard" here!!!
> >
> > Thanks,
> > Murali N
> >
> 
> Any reviews comments on this change?

No, I think you should "sell" your driver better than that. Indeed,

Q: "Why this initial version should be upstream? Why wouldn't you make
it "standard" first?"
A: Currently we are not fully using the MTD nand subsystem. That's the
intention author has introduced "non-standard" here!!!

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
