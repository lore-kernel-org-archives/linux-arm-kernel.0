From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 29 May 2014 11:05:06 -0500
Subject: [Patch v2 4/4] tty: serial: msm: Remove direct access to GSBI
In-Reply-To: <A56B810D-869A-4E4F-BC29-C9B0F6CDCE79@codeaurora.org>
References: <1398357082-5102-1-git-send-email-agross@codeaurora.org>
 <1398357082-5102-5-git-send-email-agross@codeaurora.org>
 <A56B810D-869A-4E4F-BC29-C9B0F6CDCE79@codeaurora.org>
Message-ID: <5A73A2BD-6113-4BC0-860F-BBE6A8232585@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 29, 2014, at 10:14 AM, Kumar Gala <galak@codeaurora.org> wrote:

> 
> On Apr 24, 2014, at 11:31 AM, Andy Gross <agross@codeaurora.org> wrote:
> 
>> This patch removes direct access of the GSBI registers.  GSBI configuration
>> should be done through the GSBI driver directly.
>> 
>> Signed-off-by: Andy Gross <agross@codeaurora.org>
>> ---
>> drivers/tty/serial/msm_serial.c |   48 ++-------------------------------------
>> drivers/tty/serial/msm_serial.h |    5 ----
>> 2 files changed, 2 insertions(+), 51 deletions(-)
> 
> Greg,
> 
> Any update on pulling this is for next?
> 
> - k

I?ll send it via arm-soc as the related patches are going via that path.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
