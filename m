From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 23 Mar 2018 14:45:13 -0400
Subject: [Intel-wired-lan] [PATCH v6 7/7] ixgbevf: eliminate duplicate
 barriers on weakly-ordered archs
In-Reply-To: <CAKgT0UeAJOdvqXfRw1xF+LnpGo3K7NQt_3DcJGUkiPMF+O8PTg@mail.gmail.com>
References: <1521829277-9398-1-git-send-email-okaya@codeaurora.org>
 <1521829277-9398-8-git-send-email-okaya@codeaurora.org>
 <CAKgT0UfCm4SJAhwyHKrHZnoJWKpp6-DWWVUb-YKgA2NTQhx=RA@mail.gmail.com>
 <cf6191c0-07cc-226b-d780-f488a0d7c779@codeaurora.org>
 <CAKgT0UeAJOdvqXfRw1xF+LnpGo3K7NQt_3DcJGUkiPMF+O8PTg@mail.gmail.com>
Message-ID: <66c73568-460d-6e6f-5068-e5740757c2e9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/23/2018 2:31 PM, Alexander Duyck wrote:
>> Please point me to the redundant ones.
> So from what I can tell only this file and i40e needed any additional
> mmiowb calls added. The rest are not needed.


Thanks, I'll clean up between 2..6 and then make your suggested changes
on 1 and 7.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
