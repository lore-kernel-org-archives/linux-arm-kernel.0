From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 19 Mar 2015 18:46:59 +0000 (UTC)
Subject: [PATCHv2 3/3] Documentation: DT bindings: Tegra AHB: note base
 address change
In-Reply-To: <550B155E.9050308@wwwdotorg.org>
References: <20150317083221.32662.14647.stgit@baseline>
 <20150317083221.32662.96822.stgit@baseline>
 <20150317103806.GU8656@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1503191525450.9480@utopia.booyaka.com>
 <550AEE6B.5080301@wwwdotorg.org>
 <alpine.DEB.2.02.1503191601520.9480@utopia.booyaka.com>
 <550AFF52.6070503@wwwdotorg.org>
 <alpine.DEB.2.02.1503191706340.9480@utopia.booyaka.com>
 <550B155E.9050308@wwwdotorg.org>
Message-ID: <alpine.DEB.2.02.1503191845060.9480@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Mar 2015, Stephen Warren wrote:

> We should not document Linux 4.1 as the cut-off. DT bindings are supposed to
> be OS agnostic. While it's practically unlikely, it is entirely possible for
> some other OS to have already implemented support for this binding, and the
> current binding is an ABI. We have no control over if/when any non-Linux code
> is updated to add support for a 0-based offset for existing SoCs, and
> certainly no versions of Linux or any other OS can be updated retro-actively
> except perhaps a few linux-stable versions. We can however write the binding
> in such a way as support for new SoCs requires the new 0-based address, since
> there is no binding specification for those new chips yet, and the time when
> you add the new binding documentation is the first time any OS could possibly
> add conformant support for it.
> 
> In summary, I believe the binding document must state that T20/30/114/124
> require the offset of 4 in reg value, and newer chips require no offset in the
> reg value. We can still always accept either in the Linux kernel going forward
> based on the principle of being lenient re: input data.

That's fine.  I'll send a patch for that.


- Paul
