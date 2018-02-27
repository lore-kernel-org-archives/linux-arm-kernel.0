From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Feb 2018 17:05:19 +0000
Subject: [PATCH] arm64/acpi: make ACPI boot preference configurable
In-Reply-To: <1b5a55bd-5bc7-ecd0-99f0-71dd05119743@redhat.com>
References: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
 <CACi5LpM9hn17o7i7R3GUjQYy=6DFtCFKSbDUN7A7MGBTuf7=xw@mail.gmail.com>
 <1b5a55bd-5bc7-ecd0-99f0-71dd05119743@redhat.com>
Message-ID: <20180227170518.56tvxkdh5fiochdd@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 09:44:09AM -0500, Jonathan Toppins wrote:
> For arm64 DT is suppose to *not* be the preferred method, 

This has never been the upstream position.

DT has been the default since day one, and changing this would be a
regression, as has been stated several times in the past.

If *the system vendor* intends that the system only uses ACPI, they
would not provide a DT.

If *you* prefer to use ACPI, feel free to alter your kernel command
line.

Thanks,
Mark.
