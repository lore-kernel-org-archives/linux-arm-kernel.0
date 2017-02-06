From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Feb 2017 13:47:36 +0000
Subject: [GIT PULL] ACPI IORT fixes for v4.10-rc8
In-Reply-To: <20170206133856.GA14139@red-moon>
References: <20170206133856.GA14139@red-moon>
Message-ID: <20170206134735.GJ19939@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 01:38:56PM +0000, Lorenzo Pieralisi wrote:
> Hi Will, Catalin,

Hi Lorenzo,

> please consider pulling a couple of minor ACPI IORT fixes that were
> missed in the last few -rc* cycles but should be considered for
> merging as soon as possible, hopefully before v4.10 is released.

Both of these fixes look like they fix theoretical issues, as opposed to
fixing problems actually seen on existing platforms. Given that I don't
think there's going to be an -rc8, I'll take these for 4.11 instead.

Hopefully it'll be smooth sailing now that we've got the merge path
sorted out for arm64 acpi changes.

Let me know if that's a problem.

Will
