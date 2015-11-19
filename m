From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 19 Nov 2015 08:36:40 -0700
Subject: [PATCH RFC 25/27] devicetree: bindings: Document qcom, msm-id and
 qcom,board-id
In-Reply-To: <CAL_JsqJAOEvs08Jydn9wWtM7-Oxd=MmmDER48VRF7z3Gkzt0CQ@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-26-git-send-email-lina.iyer@linaro.org>
 <CAL_JsqJAOEvs08Jydn9wWtM7-Oxd=MmmDER48VRF7z3Gkzt0CQ@mail.gmail.com>
Message-ID: <20151119153640.GC893@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19 2015 at 07:37 -0700, Rob Herring wrote:
>On Tue, Nov 17, 2015 at 4:37 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>> From: Kumar Gala <galak@codeaurora.org>
>>
>> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
>> on Qualcomm MSM platforms to determine which device tree should be
>> utilized and passed to the kernel.
>
>See [1] and the link there to the prior version which is like this one.
>
Thanks Rob. Andy Gross sent me that link and I am waiting on the changes
along with the dtb tool to make it. These patches will go away after
Stephen's changes. I just put it in here for completeness.

Thanks,
Lina

>[1] https://lkml.org/lkml/2015/10/26/651
