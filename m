From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 5 Mar 2013 11:15:04 +0100 (CET)
Subject: [PATCH] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <20130304154454.GG21620@kw.sim.vm.gnt>
References: <20110720234537.GD16297@kw.sim.vm.gnt>
 <1311295758-27493-1-git-send-email-simon@sequanux.org>
 <CAMAG_edBy1kjmEGDD76-C5T0xtha9YxMFJ6B3D8A5kHBwQ1PMQ@mail.gmail.com>
 <20110726153930.GG16297@kw.sim.vm.gnt>
 <CAMAG_ee8YBvDsdQ2zNfn-7qdyTmVYBVb8xykMMv4pg8tEswJgg@mail.gmail.com>
 <5134AF7E.5010605@keymile.com> <20130304154454.GG21620@kw.sim.vm.gnt>
Message-ID: <alpine.LFD.2.02.1303051114370.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Mar 2013, Simon Guinot wrote:
> On Mon, Mar 04, 2013 at 03:28:14PM +0100, Gerlando Falauto wrote:
> 
> AFAIK this issue is still here. I include the current Orion maintainers
> in the Cc list.

Can you please resend the patch?
