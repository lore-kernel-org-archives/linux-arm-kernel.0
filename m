From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Mar 2012 00:00:20 -0400
Subject: [PATCH 0/4] memcpy optimized with strd/ldrd
In-Reply-To: <alpine.LFD.2.02.1203280119550.24151@xanadu.home>
References: <alpine.LFD.2.02.1203280119550.24151@xanadu.home>
Message-ID: <1332993624-16552-1-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here's my version.  Lightly tested.
I have no A15 hardware to run any performance comparison though.
