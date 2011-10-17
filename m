From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Oct 2011 09:54:29 +0100
Subject: Update: ARM Sub-Architecture Maintainers workshop at Kernel
	Summit 2011
In-Reply-To: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
References: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
Message-ID: <20111017085429.GC3279@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 07:00:16AM +0100, Grant Likely wrote:
> Agenda proposals (Thanks to Nicolas and Olof):
...
> - boot architecture status

If there is still room on the agenda, I would like to get an agreement
on the best way to deal with the Hypervisor mode - (1) start the kernel
in Hyp mode or (2) have a standard HVC API in the board firmware to
allow Linux (KVM, Xen) to take control of the Hyp mode. This could fit
under the boot architecture discussion.

For (1), it could be problematic as the boot loader (e.g. U-Boot) needs
to be aware of the Hyp mode. The 2nd variant may be better but the API
needs to be kept very simple.

I know that neither KVM nor Xen for ARM are supported in the mainline
kernel but silicon vendors are already working on Cortex-A15 platforms
and it would be good if their firmware supports Linux virtualisation.

Thanks.

-- 
Catalin
