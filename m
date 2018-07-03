From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 3 Jul 2018 07:44:36 +0200
Subject: [PATCH v8 00/26] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Message-ID: <CAPDyKFpy8rpjRTBsHUFa_L0M_C=vH+6qjq=Kxdn+0j+T5NNSMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafael,

On 20 June 2018 at 19:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Changes in v8:
>  - Added some tags for reviews and acks.
>  - Cleanup timer patch (patch6) according to comments from Rafael.
>  - Rebased series on top of v4.18rc1 - it applied cleanly, except for patch 5.
>  - While adopting patch 5 to new genpd changes, I took the opportunity to
>    improve the new function description a bit.
>  - Corrected malformed SPDX-License-Identifier in patch20.

There have only been a minor comment from you at patch3 (about
squashing it with patch21), with that fixed and assuming there are no
further comments - would you like me to collect the changes and send
it to you as a pull request?

[...]

Kind regards
Uffe
