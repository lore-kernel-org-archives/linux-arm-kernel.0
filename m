From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 18:42:03 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
Message-ID: <20110823174203.GI3895@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 06:17:04PM +0100, Catalin Marinas wrote:
> Maybe we could allow (b) if SoC vendors don't provide a different API
> to set the HVBAR. But it means that kernels not aware of this feature
> would fail.

Oh, does this mean that ARM Ltd are starting to see the light in having
a common defined secure API at last - at least a subset - something which
I've mentioned several times...
