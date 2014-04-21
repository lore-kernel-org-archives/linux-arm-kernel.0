From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 21 Apr 2014 15:56:35 +0530
Subject: [PATCH v2 3/8] davinci: da850: Use cpufreq_for_each_entry macro
 for iteration
In-Reply-To: <5354F1A1.7010200@ti.com>
References: <534DB1F9.8020105@semaphore.gr>
	<5354F1A1.7010200@ti.com>
Message-ID: <CAKohpokgq=mHi5768=AVqTiRJ5UUBxgMWtpRuzQa2AntzGZZ7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2014 15:53, Sekhar Nori <nsekhar@ti.com> wrote:
> I cannot test this (or even build this) since I do not have the patch
> which adds cpufreq_for_each_entry(). The change as such looks fine to
> me. Please prefix the subject line with "ARM: " as is the convention in
> ARM world.

In case you wanna have a look:

https://lkml.org/lkml/2014/4/15/695
