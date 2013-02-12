From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Feb 2013 10:24:05 -0700
Subject: [PATCH v6 08/10] ARM: dt: Add references to tegra_car clocks
In-Reply-To: <1360580700-10245-9-git-send-email-pdeschrijver@nvidia.com>
References: <1360580700-10245-1-git-send-email-pdeschrijver@nvidia.com>
 <1360580700-10245-9-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <511A7AB5.4040607@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/2013 04:04 AM, Peter De Schrijver wrote:
> Add references to tegra_car clocks for the basic device nodes.

In this patch, you also need to remove the "clock-frequency" properties
from tegra114-*.dts board files.
