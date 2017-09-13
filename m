From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 13 Sep 2017 12:09:40 -0500
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <CACRpkdb563nCp9iptfzZOUPX6B0-qU+iWzurn-JL4PQCPHqStw@mail.gmail.com>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <CACRpkdb563nCp9iptfzZOUPX6B0-qU+iWzurn-JL4PQCPHqStw@mail.gmail.com>
Message-ID: <0dbd161e-5437-7acb-9bc9-4a7b5869a4d7@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2017 07:50 AM, Linus Walleij wrote:
>>   Since gpiochip_add_data no longer requests GPIOs before scanning for
>>   the direction (that patch was reverted), pinctrl-msm.c now specifically
>>   checks for special case.
> Waiting for Bjorn's review on these.

Bjorn,

Do you think you will have a chance to review these patches in time for 
4.14?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
