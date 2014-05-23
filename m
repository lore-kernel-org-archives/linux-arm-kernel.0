From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Fri, 23 May 2014 17:18:40 +0300
Subject: [PATCH v1 3/5] clk: gcc: Add APQ8084 Global Clock Controller
 support
In-Reply-To: <DB9EC1F3-CA2B-47C5-A677-CC1222F05614@codeaurora.org>
References: <1400775885-10296-1-git-send-email-gdjakov@mm-sol.com>
 <1400775885-10296-4-git-send-email-gdjakov@mm-sol.com>
 <DB9EC1F3-CA2B-47C5-A677-CC1222F05614@codeaurora.org>
Message-ID: <537F58C0.6090006@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2014 07:38 PM, Kumar Gala wrote:
>
> On May 22, 2014, at 11:24 AM, Georgi Djakov <gdjakov@mm-sol.com> wrote:
>
>> This patch adds support for the global clock controller found on
>> the APQ8084 based devices.
>>
>> The APQ8084 and MSM8974 share a lot of clock data, so instead of
>> duplicating all the data, we add support to the MSM8974 code.
>>
>> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
>> ---
>> drivers/clk/qcom/Kconfig                     |    4 +-
>> drivers/clk/qcom/gcc-msm8974.c               |  151 +++++++++++++++++++++++++-
>> include/dt-bindings/clock/qcom,gcc-msm8974.h |    4 +
>> 3 files changed, 154 insertions(+), 5 deletions(-)
>
> What about differences in reset?

Oops, will add this too. Thanks!

BR,
Georgi
