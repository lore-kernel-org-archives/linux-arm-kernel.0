From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 30 Aug 2009 16:46:59 -0700
Subject: [PATCH] mach-iop32x/ Add nec ns-50 / ApplianceWare sanmina
	support
In-Reply-To: <87ocr6uyhx.fsf@lechat.rtp-net.org>
References: <87ocr6uyhx.fsf@lechat.rtp-net.org>
Message-ID: <e9c3a7c20908301646w3cc8199dg392b95faad5616de@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2009 at 5:00 AM, Arnaud Patard<arnaud.patard@rtp-net.org> wrote:
> Hi,
>
> This patch is adding support for the nec ns-50/ApplianceWare Sanmina
> platform. This platforms is a nas based on iop80219 SoC.
>
> This code has been tested on 2.6.31-rc*
>

Looks ok to me except for the bit modifying arch/arm/tools/mach-types.
 You missed the notice at the top of the file:

# Please do not send patches to this file; it is automatically generated!
# To add an entry into this database, please see Documentation/arm/README,
# or visit:
#
#   http://www.arm.linux.org.uk/developer/machines/?action=new

--
Dan
