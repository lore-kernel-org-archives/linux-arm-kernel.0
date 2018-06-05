From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 5 Jun 2018 17:02:19 +0200
Subject: [PATCH v2 3/3] arm64: disable ACPI PPTT support temporarily
In-Reply-To: <1528209304-3280-3-git-send-email-sudeep.holla@arm.com>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
 <1528209304-3280-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAJZ5v0hn+sya29bZJzksDEDt2QPZDY36Hwn=ckw3ikTGp7T1Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 5, 2018 at 4:35 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Currently, ARM64 doesn't support updating the CPU topology masks on
> CPU hotplug operations. ACPI PPTT support rely on that missing feature
> which is technically not incorrect. Instead of reverting all the PPTT
> support, let's keep it simple and disable ACPI PPTT support on ARM64
> for time-being until the topology updates are added for CPU hotplug
> operations.

When is that going to happen?

Nobody else uses PPTT now.
