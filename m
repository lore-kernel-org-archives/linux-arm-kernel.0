From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 19 Jun 2014 10:05:46 +0100
Subject: [STLinux Kernel] [PATCH 4/7] ARM: stih416-b2020e: Enable PWM on
 the B2020 Rev-E
In-Reply-To: <1403103172-19856-4-git-send-email-lee.jones@linaro.org>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20140619090546.GB2131@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

> All the infrastructure is now in place for ST's PWM controller.  This
> patch takes the final step and enables the IP on the 2020 Rev-E
> development platform.

Why are you only enabling this for rev-E board?

If you make the stih415 DT PWM nodes part of this series as well, then 
assuming there is no good reason to the contary, the PWM could 
be enabled for both stih415/6 in the common stih41x-b2020 DTS file which
is also included by rev-E (assuming that PWM wiring is not some rev-E specific
thing).

Also Ajit Signed-off-by needs adding to this series.

After that:
Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
