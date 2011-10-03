From: jonathan@jonmasters.org (Jon Masters)
Date: Sun, 2 Oct 2011 21:40:19 -0400
Subject: [PATCH 2/3] define ARM-specific dma_coherent_write_sync
In-Reply-To: <1315321331.2313.10.camel@deneb.redhat.com>
References: <1314826214-22428-1-git-send-email-msalter@redhat.com>
	<1314826214-22428-3-git-send-email-msalter@redhat.com>
	<CAHkRjk7ZMDQh8sYf7N_4LLS12JU2ps8dkC34gNWNH+-Zp0p8Rg@mail.gmail.com>
	<1315319837.2313.1.camel@deneb.redhat.com>
	<CAHkRjk6TD4Qg-b3nkCE_wwj-tWr-_5evndxo3f+_6gtXEV6gNg@mail.gmail.com>
	<1315321331.2313.10.camel@deneb.redhat.com>
Message-ID: <026571E7-67F6-4B0F-998C-2A845AA22E59@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 6, 2011, at 11:02 AM, Mark Salter wrote:
> 
> In any case, the current thinking is that the original problem with
> the USB performance seen on cortex A9 multicore is probably something
> more than just write buffer delays. Once the original problem is better
> understood, we can take another look at this patch if it is still
> needed.


Thanks again for looking into this Mark. My understanding is that this is still being investigated. I'll followup with ARM to see how that's going since I've heard nothing recently :) Meanwhile, we're continuing to carry a hack based on these patches in Fedora ARM kernels.

Jon.
