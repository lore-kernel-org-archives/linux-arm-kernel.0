From: robherring2@gmail.com (Rob Herring)
Date: Thu, 13 Sep 2012 10:14:15 -0500
Subject: [PATCH 06/12] ARM: picoxcell: move debug macros to include/debug
In-Reply-To: <20120913141632.GB1338@S2101-09.ap.freescale.net>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-7-git-send-email-robherring2@gmail.com>
 <20120913141632.GB1338@S2101-09.ap.freescale.net>
Message-ID: <5051F847.6080408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 09:16 AM, Shawn Guo wrote:
> On Thu, Sep 06, 2012 at 03:12:49PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Move picoxcell debug-macro.S over to common debug macro directory.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: Jamie Iles <jamie@jamieiles.com>
>> ---
>>  arch/arm/Kconfig.debug                             |    8 ++++++++
>>  .../debug-macro.S => include/debug/picoxcell.S}    |    0
>>  2 files changed, 8 insertions(+)
>>  rename arch/arm/{mach-picoxcell/include/mach/debug-macro.S => include/debug/picoxcell.S} (100%)
>>
> Can we do that renaming right away?  I still see the following
> inclusions in the file.
> 
> #include <mach/hardware.h>
> #include <mach/map.h>

Right, I've incorporated the fix Jamie posted for this.

Rob
