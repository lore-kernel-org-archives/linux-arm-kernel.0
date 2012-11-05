From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 05 Nov 2012 14:25:59 -0800
Subject: [PATCHv9 6/8] ARM: OMAP4: retrigger localtimers after re-enabling
 gic
In-Reply-To: <1350552010-28760-7-git-send-email-t-kristo@ti.com> (Tero
 Kristo's message of "Thu, 18 Oct 2012 12:20:08 +0300")
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-7-git-send-email-t-kristo@ti.com>
Message-ID: <878vafg008.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> From: Colin Cross <ccross@android.com>
>
> 'Workaround for ROM bug because of CA9 r2pX gic control'
> register change disables the gic distributor while the secondary

Just to clarify: this is referring to PATCH 3/8 of this series, correct?

Kevin
