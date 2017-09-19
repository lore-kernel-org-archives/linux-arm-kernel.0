From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 19 Sep 2017 15:40:40 -0700
Subject: [PATCH V3 8/8] drivers: boot_constraint: Add Qualcomm display
 controller constraints
In-Reply-To: <20170904162544.GA21849@amd>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
 <f1d035bb3202dd6135e6cde9e4a142ea32a6a79c.1501578037.git.viresh.kumar@linaro.org>
 <20170904162544.GA21849@amd>
Message-ID: <20170919224040.GF30848@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04-09-17, 18:25, Pavel Machek wrote:
> Hmm. I know this is not for merge, but should this go to device tree somewhere?

Eventually yes. It should come from the boot loader in some way, which
includes DT, ACPI, etc.

This is just trying to get the core in first and once we have it
merged, we can propose DT bindings to start with.

-- 
viresh
