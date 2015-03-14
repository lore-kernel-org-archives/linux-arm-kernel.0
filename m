From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Mar 2015 14:57:03 +0100
Subject: [PATCH 04/12] KVM: x86: remove now unneeded include directory
 from Makefile
In-Reply-To: <1426263012-22935-5-git-send-email-andre.przywara@arm.com>
References: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
 <1426263012-22935-5-git-send-email-andre.przywara@arm.com>
Message-ID: <20150314135703.GC10935@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 04:10:04PM +0000, Andre Przywara wrote:
> virt/kvm was never really a good include directory for anything else
> than locally included headers.
> With the move of iodev.h there is no need anymore to add this
> directory the compiler's include path, so remove it from the x86 kvm
> Makefile.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Seems fine to me, but you need Paolo/Marcelo's ack here.

-Christoffer
