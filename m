From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 16 Apr 2012 18:34:56 +0300
Subject: [RFC PATCH] cpuidle: allow per cpu latencies
In-Reply-To: <20120410102857.GA22721@tbergstrom-lnx.Nvidia.com>
References: <1333619620-21201-1-git-send-email-pdeschrijver@nvidia.com>
 <4F7DA009.4010802@linux.intel.com>
 <CAMQu2gzwe0F3qcaTqASEPUASdG1SjpUxrBrSp-RrYLgy3W24OQ@mail.gmail.com>
 <4F7F0D52.8080305@linaro.org>
 <20120410102857.GA22721@tbergstrom-lnx.Nvidia.com>
Message-ID: <20120416153456.GB514@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> Maybe we also want to make the 'disabled' flag per CPU then or provide some
> other way the number of C states can be different per CPU?

What do you think about this? Do we also want to make the disabled flag per
CPU? Or how should we deal with a different number of C states per CPU?

Thanks,

Peter.
