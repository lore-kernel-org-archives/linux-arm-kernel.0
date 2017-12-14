From: joe@perches.com (Joe Perches)
Date: Thu, 14 Dec 2017 10:32:20 -0800
Subject: [PATCH] media: v4l: xilinx: Use SPDX-License-Identifier
In-Reply-To: <7339763.I7jApfYMM6@avalon>
References: <20171208123537.18718-1-dhaval23031987@gmail.com>
 <20171214150527.00dca6cc@vento.lan> <7339763.I7jApfYMM6@avalon>
Message-ID: <1513276340.27409.77.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-14 at 20:28 +0200, Laurent Pinchart wrote:
> Hi Mauro,
> 
> On Thursday, 14 December 2017 19:05:27 EET Mauro Carvalho Chehab wrote:
> > Em Fri,  8 Dec 2017 18:05:37 +0530 Dhaval Shah escreveu:
> > > SPDX-License-Identifier is used for the Xilinx Video IP and
> > > related drivers.
> > > 
> > > Signed-off-by: Dhaval Shah <dhaval23031987@gmail.com>
> > 
> > Hi Dhaval,
> > 
> > You're not listed as one of the Xilinx driver maintainers. I'm afraid that,
> > without their explicit acks, sent to the ML, I can't accept a patch
> > touching at the driver's license tags.
> 
> The patch doesn't change the license, I don't see why it would cause any 
> issue. Greg isn't listed as the maintainer or copyright holder of any of the 
> 10k+ files to which he added an SPDX license header in the last kernel 
> release.

Adding a comment line that describes an implicit or
explicit license is different than removing the license
text itself.
