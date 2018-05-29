From: labbott@redhat.com (Laura Abbott)
Date: Tue, 29 May 2018 14:26:56 -0700
Subject: [PATCH 0/4] arm64: align KPTI interface with x86
In-Reply-To: <20180524190932.32118-1-mlangsdo@redhat.com>
References: <20180524190932.32118-1-mlangsdo@redhat.com>
Message-ID: <4ce9e5b5-bf4d-4e64-59a8-0d85e7d05578@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2018 12:09 PM, Mark Langsdorf wrote:
> ARM64 supports KPTI, but is missing some user interface features such as
> a debugfs entry compared to the x86 implementation.

I don't see an x86 debugfs entry for PTI, only the sysfs files. Was
this something that was discussed bug never merged?

Thanks,
Laura
