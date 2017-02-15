From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 15 Feb 2017 08:05:34 -0600
Subject: [PATCH v2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
In-Reply-To: <09772d07b3d6782690728ea171ac6e9e@codeaurora.org>
References: <20170214235347.8812-1-cov@codeaurora.org>
 <6a3ea0e5-f824-380e-1c4a-3e72b160e98a@codeaurora.org>
 <09772d07b3d6782690728ea171ac6e9e@codeaurora.org>
Message-ID: <2d3173f5-8818-21cd-eccd-10fc6d5ec3bd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christopher Covington wrote:
> Nothing needs QDF2400 erratum 44. Software should try to detect the presence
> of the erratum. So I think qdf2400_e44_detected or qdf2400_e44_present would
> make sense. But those suffixes don't add substantial value in my opinion.

I'd be okay with qdf2400_e44_detected or qdf2400_e44_present.  I think it's a 
lot clearer.  Another idea is "has_qdf2400_e44".

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
