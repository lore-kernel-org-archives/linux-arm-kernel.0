From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Dec 2013 14:24:32 +0000
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131211141503.GX11468@sirena.org.uk>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <20131211141224.GG26730@mudshark.cambridge.arm.com>
 <20131211141503.GX11468@sirena.org.uk>
Message-ID: <20131211142431.GD596@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 02:15:03PM +0000, Mark Brown wrote:
> On Wed, Dec 11, 2013 at 02:12:24PM +0000, Will Deacon wrote:
> > I seem to remember Lorenzo having patches already for this, along with
> > bindings, Documentation etc. so it would be good to know how these two
> > series are supposed to interact.
> 
> He said he hadn't had time to work on the actual implementation which is
> why I picked this up - as far as I'm aware we only have the (already
> merged) binding for this.

Lorenzo (on holiday now) pushed the DT topology bindings but there are
no patches yet for reading them. I would much prefer to only describe
the topology via DT rather than MPIDR (because hardware people sometimes
have strange ideas).

-- 
Catalin
