From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Apr 2011 21:15:52 +0100
Subject: since when does ARM map the kernel memory in sections?
In-Reply-To: <201104122052.17453.pwaechtler@mac.com>
References: <201104122052.17453.pwaechtler@mac.com>
Message-ID: <20110412201552.GA7806@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 08:52:17PM +0200, Peter W?chtler wrote:
> did the ARM Linux 2.6 kernel map the kernel memory in pages in the past?
> Or was the memory always mapped in sections?

Mainline kernels have never mapped memory using anything but sections.
