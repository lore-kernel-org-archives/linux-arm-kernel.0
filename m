From: jcm@redhat.com (Jon Masters)
Date: Tue, 06 Jan 2015 11:24:43 -0500
Subject: [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20150106112000.GA8829@e104818-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <54A28B22.7090305@linaro.org>
 <20150105131302.GB14967@e104818-lin.cambridge.arm.com>
 <1797489.PjmKzBFdQA@wuerfel>
 <20150106112000.GA8829@e104818-lin.cambridge.arm.com>
Message-ID: <54AC0C4B.1000907@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/2015 06:20 AM, Catalin Marinas wrote:

> Now, what's preventing a vendor firmware from providing only ACPI
> tables? Do we enforce it in some way (arm-acpi.txt, kernel warning etc.)
> that both DT and ACPI are supported, or at least that dts files are
> merged in the kernel first?

I know of some (server) firmware that will only provide ACPI in the
medium term, so this is coming.

Jon.
