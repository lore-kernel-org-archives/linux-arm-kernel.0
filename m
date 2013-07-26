From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 26 Jul 2013 15:26:28 -0700
Subject: Zynq clk fixes
In-Reply-To: <20130726222501.7598.33060@quantum>
References: <51F26716.6030701@monstr.eu> <20130726200703.7598.86150@quantum>
 <a76b3a5d-dadc-43b3-87ee-3c65258c15d7@CO1EHSMHS029.ehs.local>
 <20130726222501.7598.33060@quantum>
Message-ID: <50ea1469-dac2-45e9-938a-60bb6c744d36@TX2EHSMHS041.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 03:25:01PM -0700, Mike Turquette wrote:
> Quoting S?ren Brinkmann (2013-07-26 14:11:52)
> > On Fri, Jul 26, 2013 at 01:07:03PM -0700, Mike Turquette wrote:
> > > Quoting Michal Simek (2013-07-26 05:09:58)
> > > > Hi Mike, [cc: Arnd and Olof]
> > > > 
> > > > Soren has found two bug fixes in zynq clk code.
> > > > Can you please add these two patches to your tree?
> > > > Will be great if you can add them to v3.11.
> > > > 
> > > > Arnd, Olof: I expect that all these clock changes should go through Mike.
> > > > If I am wrong please let me know.
> > > 
> > > Looks right to me. Do these fix regressions in the current -rc cycle?
> > 
> > I doubt there are real regressions. But since it's still early in
> > the release cycle and the driver was added in this merge window, I'd prefer
> > having it hit a release kernel with these fixes included.
> 
> I've taken these into clk-fixes and added the following to the changelog
> for each patch:
> 
> "This does not fix a specific regression but the clock driver was merged
> for 3.11-rc1, so best to fix the known bugs before the release."

Thanks.

	S?ren
