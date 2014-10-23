From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Thu, 23 Oct 2014 18:31:57 +0300
Subject: [PATCH v8 0/7] QCOM 8974 and 8084 cpuidle driver
In-Reply-To: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
Message-ID: <1414078317.4214.4.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, 

On Tue, 2014-10-07 at 15:41 -0600, Lina Iyer wrote:
> Hi,
> 
> This v8 revision of the cpuidle driver is available at
> git.linaro.org:/people/lina.iyer/linux-next cpuidle-v8
> 

Probably I missing something, but should I expect that
once these patches are applied driver could be successfully
 compiled? 

Patches definitely break bisectability. For example [PATCH v8 1/7]
is using <soc/qcom/pm.h> which is introduced [PATCH v8 4/7].

Regards,
Ivan
