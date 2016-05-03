From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 May 2016 14:58:21 -0700
Subject: Bunch of serial warnings in next at least with omap-serial
In-Reply-To: <572911BF.8000803@hurleysoftware.com>
References: <20160503203930.GQ5995@atomide.com>
 <572911BF.8000803@hurleysoftware.com>
Message-ID: <20160503215821.GR5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Hurley <peter@hurleysoftware.com> [160503 14:03]:
> Hi Tony,
> 
> On 05/03/2016 01:39 PM, Tony Lindgren wrote:
> > Hi Peter,
> > 
> > Looks like probably commit 4047b37122d1 ("serial: core: Prevent unsafe
> > uart port access, part 1") in Linux next causes tons of warnings with at
> > least omap-serial. It does not revert cleanly I have not tested with that
> > reverted. Any ideas? Dmesg output of the errors below.
> 
> Thanks for the report.
> Patch below should fix that.

Yes thanks that fixes it:

Tested-by: Tony Lindgren <tony@atomide.com>
