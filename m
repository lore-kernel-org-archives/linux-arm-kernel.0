From: kim.phillips@freescale.com (Kim Phillips)
Date: Wed, 27 Feb 2013 10:45:12 -0600
Subject: [PATCH 2/3] dtc: import latest upstream dtc
In-Reply-To: <1361934486.18483.5@driftwood>
References: <1361928975-29395-1-git-send-email-kim.phillips@freescale.com>
 <1361928975-29395-2-git-send-email-kim.phillips@freescale.com>
 <1361934486.18483.5@driftwood>
Message-ID: <20130227104512.c07c0ade0107aa7f4ec18217@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Feb 2013 21:08:06 -0600
Rob Landley <rob@landley.net> wrote:

> On 02/26/2013 07:36:14 PM, Kim Phillips wrote:
> > This updates scripts/dtc to upstream dtc commit 27cdc1b
> 
> There's an upstream for dts?

dtc - the device tree compiler, yes.

> > "Added license header to dtc/libfdt/fdt.h and libfdt_env.h"
> > from git://git.jdl.com/software/dtc.git.
> 
> That git repository has a Documentation directory with for example  
> "dts-format.txt" in it. My current linux git repository does not  
> contain a file called dts-format.txt.

this patch isn't attempting to update dts-format.txt, or any other
file that exists in the upstream dtc project that isn't present -
and used - in the kernel.  The purpose of this patch is to update
libfdt, which has in-kernel users.

Kim
