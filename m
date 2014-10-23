From: lina.iyer@linaro.org (Lina Iyer)
Date: Thu, 23 Oct 2014 09:54:35 -0600
Subject: [PATCH v8 0/7] QCOM 8974 and 8084 cpuidle driver
In-Reply-To: <1414078317.4214.4.camel@mm-sol.com>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1414078317.4214.4.camel@mm-sol.com>
Message-ID: <20141023155435.GA30210@ilina-mac.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23 2014 at 09:31 -0600, Ivan T. Ivanov wrote:
>
>Hi,
>
>On Tue, 2014-10-07 at 15:41 -0600, Lina Iyer wrote:
>> Hi,
>>
>> This v8 revision of the cpuidle driver is available at
>> git.linaro.org:/people/lina.iyer/linux-next cpuidle-v8
>>
>
>Probably I missing something, but should I expect that
>once these patches are applied driver could be successfully
> compiled?
Yes they should.
>
>Patches definitely break bisectability. For example [PATCH v8 1/7]
>is using <soc/qcom/pm.h> which is introduced [PATCH v8 4/7].
>
You are right. I missed checking compilation against each patch.
Based on some discussion, I need to see if pm.h is even needed.

>Regards,
>Ivan
>
>
