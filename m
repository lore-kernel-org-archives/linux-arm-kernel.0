From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Mar 2014 18:16:41 +0800
Subject: [PATCH v2] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140304095534.GE30596@arm.com>
References: <1393919477-27814-1-git-send-email-broonie@kernel.org>
 <20140304095534.GE30596@arm.com>
Message-ID: <20140304101641.GK13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 09:55:36AM +0000, Catalin Marinas wrote:
> On Tue, Mar 04, 2014 at 07:51:17AM +0000, Mark Brown wrote:

> > +config CPU_TOPOLOGY
> > +	bool "Support CPU topology definition"

> Thanks for the patch. I applied it but not pushed to -next yet. I wonder
> whether it makes sense to drop the description of the CPU_TOPOLOGY entry
> here so that it is no longer selectable. It will be enabled by default
> when SMP (I can do the change myself, no need to repost).

I'm totally fine with that, I only made it selectable due to the 32 bit
code doing that - I'm not sure we even need the separate symbol.
Whatever you prefer.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140304/f38e2b28/attachment.sig>
