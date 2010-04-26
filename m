From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 26 Apr 2010 12:16:15 +0300
Subject: [PATCH 0/8] Initial implementation of kdump for ARM
In-Reply-To: <4BD4EBDB.6090209@samsung.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
	<20100422120308.GD26418@gw.healthdatacare.com>
	<20100423030556.GA8012@localhost.localdomain>
	<20100423041106.GG3028@esdhcp04058.research.nokia.com>
	<4BD4EBDB.6090209@samsung.com>
Message-ID: <20100426091615.GP3028@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 26, 2010 at 03:26:51AM +0200, ext Joonyoung Shim wrote:
> On 4/23/2010 1:11 PM, Mika Westerberg wrote:
> > You need to have userspace tools (in this case kexec-tools) which load the
> > crashkernel into the running kernel. I'm planning to send my kexec-tools
> > patches to upstream after the kernel part is accepted (so that they can be
> > in sync) but I can provide you the patches if needed.
> 
> I want to test your patches too. Can you send me the kexec-tools patches?

I sent those patches to LAKML and kexec list. You can pick them up from here:
	http://lists.infradead.org/pipermail/kexec/2010-April/004029.html

Regards,
MW
