From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 3 Apr 2013 09:31:14 -0700
Subject: [PATCH] clk: divider: Introduce CLK_DIVIDER_ALLOW_ZERO flag
In-Reply-To: <20130403154027.8177.58419@quantum>
References: <1364942216-4575-1-git-send-email-soren.brinkmann@xilinx.com>
 <20130403154027.8177.58419@quantum>
Message-ID: <8fd6da66-dd3b-4e02-b958-095dee577330@VA3EHSMHS017.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 08:40:27AM -0700, Mike Turquette wrote:
> Quoting Soren Brinkmann (2013-04-02 15:36:56)
> > Dividers which have CLK_DIVIDER_ONE_BASED set have a redundant state,
> > being a divider value of zero. Some hardware implementations allow a
> > zero divider which simply doesn't alter the frequency. I.e. it acts like
> > a divide by one or bypassing the divider.
> > This flag is used to handle such HW in the clk-divider model.
> > 
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> 
> This version looks good.  Taken into clk-next.
Thanks.

	S?ren
