From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Thu, 15 Jan 2015 12:50:18 -0600
Subject: [PATCH v7 14/17] ARM64 / ACPI: Parse GTDT to initialize arch timer
In-Reply-To: <1421247905-3749-15-git-send-email-hanjun.guo@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-15-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54B80BEA.7010801@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2015 09:05 AM, Hanjun Guo wrote:
> Using the information presented by GTDT to initialize the arch
> timer (not memory-mapped).
>
> Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
