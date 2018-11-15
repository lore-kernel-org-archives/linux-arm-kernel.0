From: fweimer@redhat.com (Florian Weimer)
Date: Thu, 15 Nov 2018 11:24:27 +0100
Subject: Investigating a stack state mismatch in Linux kernel
In-Reply-To: <b7aad232-76e1-241f-00e2-77783ce30f87@linux.com> (Alexander
 Popov's message of "Wed, 14 Nov 2018 21:24:28 +0300")
References: <b7aad232-76e1-241f-00e2-77783ce30f87@linux.com>
Message-ID: <875zwyabac.fsf@oldenburg.str.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alexander Popov:

> Of course, there is a naive solution for this issue -- just skip stackleak
> instrumentation for acpi_duplicate_processor_id(). But it would be great to find
> out the reasons behind this compiler behavior. It might help to create a better
> solution.

Please show us the RTL dumps with both compilers, both before and after
the plugin pass.

Thanks,
Florian
