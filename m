From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Dec 2016 15:07:04 +0800
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: Add missing newline
In-Reply-To: <20161127213516.GF13318@lunn.ch>
References: <1480276484-5482-1-git-send-email-afaerber@suse.de>
 <20161127211727.GB13318@lunn.ch>
 <e9336935-264e-5d1c-656e-a48f89d1b015@suse.de>
 <20161127213516.GF13318@lunn.ch>
Message-ID: <20161230070703.GO6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2016 at 10:35:16PM +0100, Andrew Lunn wrote:
> On Sun, Nov 27, 2016 at 10:30:54PM +0100, Andreas F?rber wrote:
> > Hi,
> > 
> > Am 27.11.2016 um 22:17 schrieb Andrew Lunn:
> > > On Sun, Nov 27, 2016 at 08:54:44PM +0100, Andreas F?rber wrote:
> > >> Found while reviewing Marvell dsa bindings usage.
> > > 
> > > Hi Andreas
> > > 
> > > It is good practice to put the maintainer you expect to accept the
> > > patch on the To: line. You have at least two different maintainers on
> > > Cc: so it is currently ambiguous. And these lists can be high volume,
> > > so without a copy in the maintainers inbox, patches can be overlooked.
> > 
> > As a vf610 DT patch with LAKML in To I am expecting it to be handled by
> > Shawn or anyone from the NXP/ARM side.
> 
> So please have Shawn as To:
> 
> The patch you are fixing went through Dave Miller, who is also on Cc:,
> hence the ambiguity.

The good practice was broken from the beginning when patch "arm: vf610:
zii devel b: Add support for switch interrupts") went through net tree,
even without me on copy.

Shawn
