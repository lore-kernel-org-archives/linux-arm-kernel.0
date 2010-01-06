From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jan 2010 16:27:31 +0000
Subject: [PATCH 02/11] arm: use generic infrastructure for early params
In-Reply-To: <1261479296.246097.171417450949.2.gpush@pororo>
References: <1261479296.245235.191110925832.0.gpush@pororo>
	<1261479296.246097.171417450949.2.gpush@pororo>
Message-ID: <20100106162731.GB1728@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 06:54:56PM +0800, Jeremy Kerr wrote:
> The ARM setup code includes its own parser for early params, there's
> also one in the generic init code.

This is something which should be separate from the rest of the DT
patch - could we have this as a patch which can be applied to the
current kernel tree please?
