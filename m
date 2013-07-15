From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 15 Jul 2013 11:27:24 +0200
Subject: [PATCH] Route kbd LEDs through the generic LEDs layer
In-Reply-To: <20130707101028.GD5651@type.youpi.perso.aquilenet.fr> (Samuel
 Thibault's message of "Sun, 7 Jul 2013 12:10:28 +0200")
References: <201011112205.oABM5KVJ005298@imap1.linux-foundation.org>
 <201011111440.07882.dmitry.torokhov@gmail.com>
 <20110102090935.GV32469@atrey.karlin.mff.cuni.cz>
 <20110102103210.GA25662@core.coreip.homeip.net>
 <20110102225741.GX5480@const.famille.thibault.fr>
 <20110112182702.GA9168@core.coreip.homeip.net>
 <20111114040613.GA4992@type.famille.thibault.fr>
 <20121221003449.GA6999@type.youpi.perso.aquilenet.fr>
 <20130707101028.GD5651@type.youpi.perso.aquilenet.fr>
Message-ID: <87wqos9nr7.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Samuel" == Samuel Thibault <samuel.thibault@ens-lyon.org> writes:

 Samuel> This permits to reassign keyboard LEDs to something else than keyboard "leds"
 Samuel> state, by adding keyboard led and modifier triggers connected to a series
 Samuel> of VT input LEDs, themselves connected to VT input triggers, which
 Samuel> per-input device LEDs use by default.  Userland can thus easily change the LED
 Samuel> behavior of (a priori) all input devices, or of particular input devices.

 Samuel> This also permits to fix #7063 from userland by using a modifier to implement
 Samuel> proper CapsLock behavior and have the keyboard caps lock led show that modifier
 Samuel> state.

 Samuel> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
 Samuel> [ebroder at mokafive.com: Rebased to 3.2-rc1 or so, cleaned up some includes, and fixed some constants]
 Samuel> Signed-off-by: Evan Broder <evan@ebroder.net>

Looks good to me. Samuel, thanks for picking this up again.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
