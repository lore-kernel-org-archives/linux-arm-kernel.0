From: jlu@pengutronix.de (Jan =?ISO-8859-1?Q?L=FCbbe?=)
Date: Tue, 22 Jan 2013 10:24:26 +0100
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
Message-ID: <1358846666.3996.3.camel@coredoba.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-22 at 02:24 +0000, Paul Walmsley wrote:
> Regarding the AM33xx test failures with appended DTBs, it would be very 
> helpful if especially the TI people could try reproducing the problem.
> Otherwise it's going to cause problems with merging any new AM33xx 
> patches, since I won't be able to test them without additional work.  
> Plus, this is something that used to work up until d01e4afd, so something 
> isn't right.

Just a guess, but there can be problems when the appended DTB crosses an
1MB boundary. See this mail for details and a patch:
http://www.spinics.net/lists/arm-kernel/msg216898.html

Regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
