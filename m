From: hean.loong.ong@intel.com (Ong, Hean Loong)
Date: Wed, 15 Aug 2018 01:44:46 +0000
Subject: [PATCH10 3/3] ARM:drm ivip Intel FPGA Video and Image
 Processing Suite
In-Reply-To: <4c9770ce-999f-2ec3-60fb-397c4cec23a2@kernel.org>
References: <1534237029-2648-1-git-send-email-hean.loong.ong@intel.com>
 <1534237029-2648-4-git-send-email-hean.loong.ong@intel.com>
 <4c9770ce-999f-2ec3-60fb-397c4cec23a2@kernel.org>
Message-ID: <1534297485.3035.2.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-08-14 at 10:46 -0500, Dinh Nguyen wrote:
> 
> On 08/14/2018 03:57 AM, Hean-Loong, Ong wrote:
> > 
> > From: Ong Hean Loong <hean.loong.ong@intel.com>
> > 
> > Driver for Intel FPGA Video and Image Processing Suite Frame Buffer
> > II.
> > The driver only supports the Intel Arria10 devkit and its variants.
> Why only Arria10? That's not true is it? I remember running a version
> of
> this on the Cyclone5 SoCKit.
> 
During Cyclone5 SoCkit it was the older version of the Frambuffer. From
the IP owner the FrameBuffer II design is only available for Arria10

> Dinh
> 
