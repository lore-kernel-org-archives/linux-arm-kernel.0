From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 27 Feb 2018 14:55:18 +0000
Subject: [PATCH] arm64/acpi: make ACPI boot preference configurable
In-Reply-To: <1454e833-e3b9-780b-c5db-a6f73e799352@redhat.com>
References: <85047448dc1d2d3c725b6b78d5ef2a89fc81b83b.1519659254.git.jtoppins@redhat.com>
 <CAKv+Gu9FVD18v6WA8MMG5LFX9GPObq_79hFuYv6j+S98a5Ej6w@mail.gmail.com>
 <1454e833-e3b9-780b-c5db-a6f73e799352@redhat.com>
Message-ID: <b0f9d2d3-9029-1581-9330-807fab3b2d44@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/18 14:28, Jonathan Toppins wrote:
>> 'only intended to be booted via ACPI' is a property of the system, not
>> of the OS. If you need this functionality for development, you can
>> append 'acpi=on' to the kernel command line via kconfig.
> 
> This is not for development this is for production rate shipping firmware.

Obvious question: if this is "production" firmware on systems which "do 
not support DT", what the hell is a non-trivial DT doing in there in the 
first place?

Robin.
