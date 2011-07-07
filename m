From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 18:15:30 +0100
Subject: [RFC PATCH 00/17] ARM: common idle infrastructure
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20110707171530.GC20403@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 04:50:13PM +0100, Lorenzo Pieralisi wrote:
> This patchset is a first attempt at providing a consolidation of idle
> code for the ARM processor architecture and a request for comment on
> the provided methodology.
> It relies and it is based on kernel features such as suspend/resume,
> pm notifiers and common code for cpu_reset().

Please delay this for the next merge window - there's too much going on
at the moment to even start looking at this patch set.

Thanks.
