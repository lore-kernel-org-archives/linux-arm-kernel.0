From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Mar 2014 18:52:27 +0800
Subject: [PATCH v2] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140304102806.GH30596@arm.com>
References: <1393919477-27814-1-git-send-email-broonie@kernel.org>
 <20140304095534.GE30596@arm.com>
 <20140304101641.GK13126@sirena.org.uk>
 <20140304102806.GH30596@arm.com>
Message-ID: <20140304105227.GM13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 10:28:06AM +0000, Catalin Marinas wrote:

> > I'm totally fine with that, I only made it selectable due to the 32 bit
> > code doing that - I'm not sure we even need the separate symbol.
> > Whatever you prefer.

> Like that?

Looks good to me!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140304/b01453f2/attachment-0001.sig>
