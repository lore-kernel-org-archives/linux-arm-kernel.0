From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 May 2015 11:37:10 +0100
Subject: arm syscall fast path can miss a ptrace syscall-exit
In-Reply-To: <5564F5E0.7080108@redhat.com>
References: <5554F3E4.8020307@redhat.com>
 <20150514193553.GD2067@n2100.arm.linux.org.uk>
 <55550EBA.3050708@redhat.com> <5564F5E0.7080108@redhat.com>
Message-ID: <20150528103710.GZ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 26, 2015 at 03:38:24PM -0700, Josh Stone wrote:
> Hi Russell,
> 
> Do you plan to commit this check for syscall flags?

It's been committed since 15th May, but as it's the only fix I have
queued up (and my focus has been elsewhere) it hasn't been sent yet.
It's been in linux-next for a while now.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
