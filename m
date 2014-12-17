From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 17 Dec 2014 10:31:41 +0100
Subject: [PATCH V8 00/14] drm/exynos: few patches to enhance bridge chip
 support
In-Reply-To: <3197445.qizQc0zeRb@avalon>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
 <CAEC9eQOrKw2Z1q-ztFfadXmsL3CTcAkkv9kcS2QnDOAVSh2AuQ@mail.gmail.com>
 <548ABAB6.6010200@collabora.co.uk> <3197445.qizQc0zeRb@avalon>
Message-ID: <54914D7D.9060108@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Laurent and Tomi,

On 12/16/2014 12:37 AM, Laurent Pinchart wrote:
> Hi Javier,
>> Tomi and Laurent,
>> 
>> You asked Ajay to change his series to use the video port and enpoints DT
>> bindings instead of phandles, could you please review his latest version?
>> 
>> I guess is now too late for 3.19 since we are in the middle of the merge
>> window but it would be great if this series can at least made it to 3.20.
> 
> I don't have time to review the series in details right now, but I'm happy 
> with the DT bindings, and have no big issue with the rest of the patches. I 
> don't really like the of_drm_find_bridge() concept introduced in 03/14 but I 
> won't nack it given lack of time to implement an alternative proposal. It's an 
> internal API, it can always be reworked later anyway.
> 

Thanks a lot for taking the time to look at the DT bindings, then I guess
that the series are finally ready to be merged?

Ajay's series don't apply cleanly anymore because it has been a while since
he posted it but he can rebase on top of 3.19-rc1 once it is released and
re-resend.

Best regards,
Javier
