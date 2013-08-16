From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 16 Aug 2013 14:50:44 -0500
Subject: [PATCH RFC 1/3] spmi: Linux driver framework for SPMI
In-Reply-To: <20130816194714.GH4035@joshc.qualcomm.com>
References: <cover.1376596224.git.joshc@codeaurora.org>
 <02deef1d90121011ab1df90ad704ef0ee36e2584.1376596224.git.joshc@codeaurora.org>
 <20130816184614.GA31510@kroah.com>
 <20130816194714.GH4035@joshc.qualcomm.com>
Message-ID: <20130816195044.GI4035@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 02:47:14PM -0500, Josh Cartwright wrote:
> > 
> > Why?  If debugfs isn't enabled, the functions should just compile away
> > with the debugfs_() calls, so no need to do this type of thing here,
> > right?
> 
> Not sure I follow you, but it may be because this is a bit misleading.
> 
> Currently CONFIG_DEBUG_FS is being extended to also mean "do you want
> the SPMI core to create device entries?".  It would probably make more
                      debugfs -^

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
