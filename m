From: khilman@ti.com (Kevin Hilman)
Date: Wed, 16 May 2012 15:48:51 -0700
Subject: [PATCHv2 05/19] ARM: OMAP4: PM: save/restore all CM1/2 settings
 in OFF mode
In-Reply-To: <1336990730-26892-6-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Mon, 14 May 2012 13:18:36 +0300")
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-6-git-send-email-t-kristo@ti.com>
Message-ID: <87zk977ne4.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> From: Rajendra Nayak <rnayak@ti.com>
>
> Restore all CM1/2 module registers as they are lost in OFF mode.

Save and restore?

Also, as in the previous patch.  Can this be done using cluster PM
notifier as well?    (I realize that this series was probably done
before the PM notifiers were upstream, but now that we have them, we
should use them.)

Kevin
