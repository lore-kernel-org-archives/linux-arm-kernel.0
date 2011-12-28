From: eric.miao@linaro.org (Eric Miao)
Date: Wed, 28 Dec 2011 20:23:05 +0800
Subject: [PATCH 1/2] ARM: imx: add dt support of IRAM
In-Reply-To: <4EF9F85E.5020203@gmail.com>
References: <1324949596-27214-1-git-send-email-jason.chen@linaro.org>
 <4EF9F85E.5020203@gmail.com>
Message-ID: <CAMPhdO_o9AGNh1i7RYN2zZfR9AFdAMjWwc4kifLfdb0Ar9zXog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2011 at 12:54 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 12/26/2011 07:33 PM, Jason Chen wrote:
>> Signed-off-by: Jason Chen <jason.chen@linaro.org>
>> Signed-off-by: Eric Miao <eric.miao@linaro.org>
>> ---
>> ?arch/arm/plat-mxc/include/mach/iram.h | ? ?6 ++++++
>> ?arch/arm/plat-mxc/iram_alloc.c ? ? ? ?| ? 16 ++++++++++++++++
>> ?2 files changed, 22 insertions(+), 0 deletions(-)
>>
>
> Whatever happened to the generic SRAM support? That with a common DT
> binding and init would be better.
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-May/051472.html

+1, this one looks good.
