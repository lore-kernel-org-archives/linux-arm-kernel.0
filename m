From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 22 Jan 2013 10:40:46 +0100
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <1358846666.3996.3.camel@coredoba.hi.pengutronix.de> ("Jan
 =?utf-8?Q?L=C3=BCbbe=22's?= message of "Tue, 22 Jan 2013 10:24:26 +0100")
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
 <1358846666.3996.3.camel@coredoba.hi.pengutronix.de>
Message-ID: <87ham95zdt.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Jan" == Jan L?bbe <jlu@pengutronix.de> writes:

 Jan> On Tue, 2013-01-22 at 02:24 +0000, Paul Walmsley wrote:
 >> Regarding the AM33xx test failures with appended DTBs, it would be very 
 >> helpful if especially the TI people could try reproducing the problem.
 >> Otherwise it's going to cause problems with merging any new AM33xx 
 >> patches, since I won't be able to test them without additional work.  
 >> Plus, this is something that used to work up until d01e4afd, so something 
 >> isn't right.

 Jan> Just a guess, but there can be problems when the appended DTB
 Jan> crosses an 1MB boundary. See this mail for details and a patch:
 Jan> http://www.spinics.net/lists/arm-kernel/msg216898.html

True, but that doesn't seem to be the case here:
ls -la arch/arm/boot/uImage
-rw-r--r-- 1 peko peko 3945127 Jan 22 09:26 arch/arm/boot/uImage

E.G. far from the 1MB boundary.

-- 
Bye, Peter Korsgaard
