From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Mon, 23 Nov 2015 15:45:45 +0100
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <20151122065146.GD26074@amd>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <20150713131902.GH26485@atomide.com>
 <20151012201640.GQ23801@atomide.com> <201510122225.12786@pali>
 <20151012204509.GT23801@atomide.com> <20151013143746.GJ23104@pali>
 <20151105114041.GC27908@pali> <20151105161756.GG3078@atomide.com>
 <5643E716.9080204@gmail.com> <20151122065146.GD26074@amd>
Message-ID: <20151123144545.GD24147@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 November 2015 07:51:46 Pavel Machek wrote:
> On Wed 2015-11-11 17:10:46, Frank Rowand wrote:
> > Adding devicetree list.
> > 
> > Thread starts at
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354459.html
> > 
> > On 11/5/2015 8:17 AM, Tony Lindgren wrote:
> > > * Pali Roh?r <pali.rohar@gmail.com> [151105 03:41]:
> > >> On Tuesday 13 October 2015 16:37:46 Pali Roh?r wrote:
> > >>> On Monday 12 October 2015 13:45:09 Tony Lindgren wrote:
> > >>>> * Pali Roh?r <pali.rohar@gmail.com> [151012 13:29]:
> > >>>>> On Monday 12 October 2015 22:16:40 Tony Lindgren wrote:
> > >>>>>>
> > >>>>>> Pali, any news on posting an updated series with the comments
> > >>>>>> addressed in this thread? It seems that we all pretty much agree
> > >>>>>> what needs to be done.
> > 
> > I'm not real happy with the concept of patches 4 and 5 in this series.
> > My concern is that those two patches are using the FDT as a transport
> > mechanism for a binary blob (the atags object).
> 
> Umm. Ok. Do you have alternative proposal that works for everyone?
> 
> I mean. This discussion was going for quite a long time, and it would
> be nice to have some solution... patch proposal... something.
> 									Pavel

Yes, discussion is going for a long time! So should I spend time for
adding documentation to my solution (this is last one thing which is
missing)? Or my solution is wrong and somebody else will propose new?
I do not want to spend time on something which will be rejected and
discarded.

-- 
Pali Roh?r
pali.rohar at gmail.com
