From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Feb 2012 15:55:07 +0000
Subject: ARM: add xz kernel compression support
In-Reply-To: <1329404057-26346-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1329404057-26346-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <20120216155507.GO13673@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 03:54:15PM +0100, Michael Opdenacker wrote:
> This patchset applies on Linus' tree
> 
> It adds xz support to the ARM tree. x86 already has it, so let's have it too!
> My benchmarks below show that xz is better than lzma in terms of image size
> and uncompression time.

Have you checked what's in my tree?  Have you checked patch 7001/2 ?
