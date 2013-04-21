From: tbm@cyrius.com (Martin Michlmayr)
Date: Sun, 21 Apr 2013 17:12:42 +0100
Subject: [PATCH] Enable PCIe port 1 on QNAP TS-11x/TS-21x
In-Reply-To: <20130421154704.GV2824@lunn.ch>
References: <20130421152802.GA1408@jirafa.cyrius.com>
 <20130421154704.GV2824@lunn.ch>
Message-ID: <20130421161241.GC26943@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrew Lunn <andrew@lunn.ch> [2013-04-21 17:47]:
> For the DT based board, this will not help. Did you notice the FIXME?

Yes, and I've read your discussions about this topic in the meantime.

I'll send a new patch for the non-DT case only since this is what's
relevant for current kernels.

> Now that i know both ports are needed, i will fix the DT for 3.11 when
> we introduce PCI bindings via DT.

Thanks.
-- 
Martin Michlmayr
http://www.cyrius.com/
