From: gnurou@gmail.com (Alexandre Courbot)
Date: Sun, 20 Mar 2016 15:55:07 +0900
Subject: [PATCH v2 1/5] dt-bindings: gk20a: Fix typo in compatible name
In-Reply-To: <20160318203140.GA10337@rob-hp-laptop>
References: <1458010724-10945-1-git-send-email-acourbot@nvidia.com>
 <1458010724-10945-2-git-send-email-acourbot@nvidia.com>
 <20160318203140.GA10337@rob-hp-laptop>
Message-ID: <CAAVeFuJ047U+Jdv2G6JVBMnA9y-wRx9kog0e7uoGAPUJqUEg-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 19, 2016 at 5:31 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Mar 15, 2016 at 11:58:40AM +0900, Alexandre Courbot wrote:
>> The correct compatible name is "nvidia,gk20a".
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  Documentation/devicetree/bindings/gpu/nvidia,gk20a.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Acked-by: Rob Herring <robh@kernel.org>
>
> This may be what is used, but having the SoC name would be preferred
> assuming gk20a is in multiple SoCs.

gk20a is exclusive to t124 (and so is gm20b to t210), so there can be
no confusion here. This is why we eventually went for the shorter
compatible string (and forgot to update the DT documentation).
