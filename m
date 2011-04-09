From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 9 Apr 2011 12:49:58 +0300
Subject: 2.6.39-rc2 on zaurus: does not build, does not boot
In-Reply-To: <201104080931.11202.marek.vasut@gmail.com>
References: <20110408062646.GA1472@ucw.cz>
	<201104080931.11202.marek.vasut@gmail.com>
Message-ID: <201104091249.59159.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 April 2011 10:31:10 Marek Vasut wrote:
> On Friday 08 April 2011 08:26:46 Pavel Machek wrote:
> > Hi!
> > 
> > Build fix is below. Maybe it is pending in the trees somewhere
> > already...
> 
> Fix is already there, it was broken by a patch from someone recently.
> Thanks though

I broke it accidently, sorry :) you can enable CONFIG_FB_PXA_OVERLAY as 
temporary workaround

Regards
Vasily
