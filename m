From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Fri, 4 Dec 2009 13:33:58 +0200
Subject: [PATCH 1/2] ep93xx: implemented watchdog timer driver for
	TS-72xx SBCs
In-Reply-To: <5r4nu6-pia.ln1@chipmunk.wormnet.eu>
References: <cover.1259866661.git.mika.westerberg@iki.fi>
	<3518ebf38d7a0038262cd20beb5283198e99e22e.1259866661.git.mika.westerberg@iki.fi>
	<5r4nu6-pia.ln1@chipmunk.wormnet.eu>
Message-ID: <20091204113358.GE5626@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2009 at 10:28:21AM +0000, Alexander Clouter wrote:

> ....and also on the TS-78XX boards.  Although my TS-7800 board is being 
> neglected at the moment it would be great if you could replace 
> everywhere you put ts72xx with ts7xxx and such.  Means when I add the 
> platform hooks for the TS-78xx I do not have to submit a patch that is a 
> rather intrusive rename/relabelling one.

Hi,

Is the TS-7800 watchdog timer similar than the ones in TS-72xx SBCs? I couldn't
find any documentation about that in TS web site. If this is the case then
I would be more than happy to do this stuff.

Thanks,
MW
