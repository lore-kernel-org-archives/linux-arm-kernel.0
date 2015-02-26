From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 26 Feb 2015 11:00:09 -0800
Subject: [PATCH 01/12] ARM: dts: apq8064: add RPM regulators support
In-Reply-To: <1424678093-12966-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424678093-12966-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <CAJAp7OgOjsLe2c66k8ocSCpg_JtHCJbofcxjbgBoG6fd8iFPxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 22, 2015 at 11:54 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> This patch adds rpm node to apq8064 dt as rpm would be used by other
> devices for regulator support. Also adds all the regulators in the rpm.
>

This looks good, with Kumars suggestion of GIT defines
Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

However, this binding is not merged yet and Stephen have requesting a
complete redesign of the binding as well as the code. So that has to
be concluded first, I presume.


Separate of that, as it's highly likely that everyone will follow the
pcb design guidelines for apq8064 the vin-supplies should be okay to
specify at this level (and not in all board files). Perhaps also the
switching frequencies for the SMPSs?

Regards,
Bjorn
