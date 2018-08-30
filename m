From: wufan@codeaurora.org (wufan)
Date: Thu, 30 Aug 2018 11:11:27 -0600
Subject: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <CABo9ajDf09BHsq0NOs99NSD6zOV5N-CDvgvQrGi9p_wLjpJ24g@mail.gmail.com>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org>
 <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com>
 <000f01d4406f$6ce8f160$46bad420$@codeaurora.org>
 <1ac15a80-6f9a-cf9d-8e79-37d10549a4ca@arm.com>
 <CABo9ajDf09BHsq0NOs99NSD6zOV5N-CDvgvQrGi9p_wLjpJ24g@mail.gmail.com>
Message-ID: <001301d44084$7dc63730$7952a590$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler, 

> > Is printing the handle to the kernel log critical?
> >
> 
> I don't see why we would need this print. The bank/device print is enough to
> map what is shown in dmesg to an SMBIOS entry if that's really needed.

This change is mostly for convenience. I'll revert it since we have two votes
against it now. 

Thanks,
Fan
