From: robherring2@gmail.com (Rob Herring)
Date: Mon, 14 May 2012 08:40:01 -0500
Subject: [PATCH 3/4] clk: add DT clock binding support
In-Reply-To: <20120501225900.GC17311@gmail.com>
References: <1334003101-17274-1-git-send-email-robherring2@gmail.com>
 <1334003101-17274-4-git-send-email-robherring2@gmail.com>
 <20120501225900.GC17311@gmail.com>
Message-ID: <4FB10B31.7080207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2012 05:59 PM, Mike Turquette wrote:
> On 20120409-15:25, Rob Herring wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
> snip
>> ---
>>  .../devicetree/bindings/clock/clock-bindings.txt   |  117 ++++++++++++++++
>>  .../devicetree/bindings/clock/fixed-clock.txt      |   22 +++
>>  drivers/clk/clk.c                                  |  140 ++++++++++++++++++++
>>  drivers/clk/clkdev.c                               |   77 +++++++++++
>>  include/linux/clk-provider.h                       |   14 ++
>>  include/linux/clk.h                                |   19 +++
>>  6 files changed, 389 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/clock/clock-bindings.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/fixed-clock.txt
> 
> Hi Rob,
> 
> Patches 1 & 2 are trivial and certainly aimed at clk-next, so I've taken
> them in.  This patch is a bit more difficult as it touches the common
> clk code, clkdev/clk.h and some DT docs.
> 
> Are you looking for me to take this patch into clk-next?  I'm just
> trying to avoid any more clk dependency issues than we already have...
> 

I think that makes the most sense as it appears I'm dependent on
clk-next now. I'm rebasing my patches on clk-next now.

Rob
