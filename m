From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Jan 2015 17:03:24 +0000
Subject: [RFC 8/8] ARM64: Add uprobe support
In-Reply-To: <0694af6935f9c6873ef8d25ad51630a40a74a116.1420038188.git.panand@redhat.com>
References: <cover.1420038188.git.panand@redhat.com>
 <0694af6935f9c6873ef8d25ad51630a40a74a116.1420038188.git.panand@redhat.com>
Message-ID: <20150108170324.GT11583@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 31, 2014 at 03:21:24PM +0000, Pratyush Anand wrote:
> This patch adds support for uprobe on ARM64 architecture.
> 
> Unit test for following has been done so far and they have been found
> working
> 1. Normal instruction, which can be probed like sub, ldr, add etc.
> 2. Instructions which can be simulated like ret.
> 3. uretprobe

I'm assuming that means you don't support compat (AArch32) tasks with this?
How do you enforce that?

Will
