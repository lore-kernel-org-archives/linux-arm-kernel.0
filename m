From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Wed, 28 Jan 2015 01:09:39 +0200
Subject: N900 v3.19-rc5 arm atags_to_fdt.c is broken
In-Reply-To: <alpine.LFD.2.11.1501271309450.1322@knanqh.ubzr>
References: <201501232239.55801@pali> <201501232336.36187@pali>
 <20150126161454.GE28663@atomide.com> <201501261723.10505@pali>
 <20150126170323.GF28663@atomide.com>
 <alpine.LFD.2.11.1501261318590.1322@knanqh.ubzr>
 <20150127133739.GB25306@amd>
 <alpine.LFD.2.11.1501271014160.1322@knanqh.ubzr>
 <20150127175359.GE11502@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501271309450.1322@knanqh.ubzr>
Message-ID: <20150127230938.GB591@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 01:50:22PM -0500, Nicolas Pitre wrote:
> Hence the ATAG-to-DT compat code in the decompressor.  This 
> was meant to smooth things around the transition to DT, etc.  After all, 
> those devices with non-replaceable bootloaders where shim layers are not 
> possible should get out of commission eventually?

Probably after 5 years there are still people using and hacking mainline
Linux with N900 etc., and newer OMAPs (since there no "useful" devices)
are long forgotten...

A.
