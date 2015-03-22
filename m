From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 22 Mar 2015 08:44:29 -0700
Subject: [PATCH] sun4i-timer: Only register a sched_clock on sun4i and
 sun5i
In-Reply-To: <1426949157-24033-1-git-send-email-hdegoede@redhat.com>
References: <1426949157-24033-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150322154429.GI2774@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 21, 2015 at 03:45:57PM +0100, Hans de Goede wrote:
> sun6i and newer have an arm arch timer which is a better sched_clock source
> then the sun4i-timer, and sched_clock does not have priorities, so do not
> register the sun4i-timer sched_clock at all on sun6i and newer.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150322/e58e7b16/attachment.sig>
