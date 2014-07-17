From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Jul 2014 14:26:51 +0200
Subject: [PATCH v3 3/3] arm64: Use include/asm-generic/io.h
In-Reply-To: <20140717120441.GI18203@arm.com>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
 <1405508484-18303-3-git-send-email-thierry.reding@gmail.com>
 <20140717120441.GI18203@arm.com>
Message-ID: <20140717122649.GA1006@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 17, 2014 at 01:04:41PM +0100, Catalin Marinas wrote:
> On Wed, Jul 16, 2014 at 12:01:24PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > Include the generic I/O header file so that duplicate implementations
> > can be removed. This will also help to establish consistency across more
> > architectures regarding which accessors they support.
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v3:
> > - add io{read,write}{16,32}be() to match what 32-bit ARM does
> 
> It looks fine. Thanks.

Great. Russell hasn't commented on this yet, anyone know how to get his
attention?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/903ffc89/attachment.sig>
