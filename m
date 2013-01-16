From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 16 Jan 2013 22:04:05 +0800
Subject: [PATCH 4/4] ARM: uncompress: support uncompress debug for
 multiplatform build
In-Reply-To: <20130115190401.GA28333@quad.lixom.net>
References: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
 <1355319945-3199-5-git-send-email-shawn.guo@linaro.org>
 <20130111191116.GA999@quad.lixom.net>
 <20130112032934.GA14865@S2101-09.ap.freescale.net>
 <20130115190401.GA28333@quad.lixom.net>
Message-ID: <20130116140403.GA25618@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 11:04:01AM -0800, Olof Johansson wrote:
> Most functionality to deal with this already exist in the
> include/debug/*.S files files, you just need to instantiate the macros
> somewhere (compressed/head.S, or a separate file), and wrap the calls
> to those instantiated assembly functions in a generic header file.
> 
> That way, every platform that has a DEBUG_LL implementation should be able to
> reuse that, and no need to enable every platform one by one.
> 
Ok, got your point.  I'm working on a solution as what you suggest here.
So please ignore that pull request I sent.

Shawn
