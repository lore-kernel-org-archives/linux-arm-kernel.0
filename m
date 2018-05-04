From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 4 May 2018 11:34:04 +0530
Subject: [PATCH v4 08/14] dt: qcom: Add opp and thermal to the msm8996
In-Reply-To: <20180402091617.GA3572@vireshk-i7>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-9-git-send-email-ilialin@codeaurora.org>
 <20180402091617.GA3572@vireshk-i7>
Message-ID: <CAKohpo=cw+2Leuwa6XjEYh4kVYK093A5eckUmPBDutgqeqpvog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 April 2018 at 14:46, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>> +     cluster0_opp: opp_table0 {
>> +             compatible = "operating-points-v2";
>> +             opp-shared;
>
> Is Kryo like krait where CPUs do DVFS independently ? If yes, then opp-shared
> thing should be dropped.

Have you ever replied to this question ? Sorry, but I am not able to
find it in my inbox :(
