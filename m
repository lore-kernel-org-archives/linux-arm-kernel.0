From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 22 Dec 2017 11:56:42 +0100
Subject: [PATCH v2 4/5] ARM: dts: Add support for emtrion emCON-MX6 series
In-Reply-To: <b41bc779-28e8-5a87-6f66-f5874dba8d1e@suse.de>
References: <95F51F4B902CAC40AF459205F6322F01B7FDFECC3C@BMK019S01.emtrion.local>
 <20171222104028.GC18255@piout.net>
 <b41bc779-28e8-5a87-6f66-f5874dba8d1e@suse.de>
Message-ID: <20171222105642.GD18255@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Philippe

On 22/12/2017 at 11:43:33 +0100, Andreas F?rber wrote:
> >> I'll change it for v3 of this patch however it will end up like this:
> >> //SPDX-License...
> > 
> > That should be /* SPDX-License */, // is for c files.
> 
> Got any reference for that? Since we're using the C preprocessor before
> feeding them to dtc, we can use the same // style for both, builds fine.
> 
> Only for my private DT overlay files that I use directly with dtc I
> couldn't adopt that style.
> 
The doc states:

If a specific tool cannot handle the standard comment style, then the
appropriate comment mechanism which the tool accepts shall be used. This
is the reason for having the "/\* \*/" style comment in C header
files.

I interpreted that as dtc doesn't handle // comments, use /**/

But I agree it also states:
.dts{i}:	  // SPDX-License-Identifier: <SPDX License Expression>

So I think we will end up with a mix of both.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
