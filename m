From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Aug 2011 20:35:00 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix build of dev- infrastructure for
	module.h changes
In-Reply-To: <20110801110318.GA11811@windriver.com>
References: <1312158567-22483-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110801110318.GA11811@windriver.com>
Message-ID: <20110801113454.GA16629@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2011 at 07:03:19AM -0400, Paul Gortmaker wrote:

> I double checked what I did against yours, and I was using the
> more minimal export.h in dev-wdt.c file.  Did I miss something
> where it really requires all of module.h file?

I don't know, my only interest at the time was in fixing the build for
my primary development platform after it broke suddenly during the merge
window.  Like I said yesterday the first I knew about any changes in
module.h was when Dave Jones mentioned it in response to my fix for
cpufreq, I had assumed it was an ARM-specific change.
