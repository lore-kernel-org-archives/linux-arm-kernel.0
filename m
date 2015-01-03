From: inki.dae@samsung.com (Inki Dae)
Date: Sat, 03 Jan 2015 15:47:59 +0900
Subject: [PATCH V8 00/14] drm/exynos: few patches to enhance bridge chip
 support
In-Reply-To: <CAEC9eQPKC05C0uJr0eKEuG1eqWohYqV=2seWQtanRFryDgF0ng@mail.gmail.com>
References: <1416045309-13359-1-git-send-email-ajaykumar.rs@samsung.com>
 <CAEC9eQOrKw2Z1q-ztFfadXmsL3CTcAkkv9kcS2QnDOAVSh2AuQ@mail.gmail.com>
 <548ABAB6.6010200@collabora.co.uk> <3197445.qizQc0zeRb@avalon>
 <54914D7D.9060108@collabora.co.uk>
 <CAPj87rN4HZzDt5JBLyTRmKZs7XcOG=0ha7ZQf9hmjPAFgTyhYQ@mail.gmail.com>
 <CAEC9eQPKC05C0uJr0eKEuG1eqWohYqV=2seWQtanRFryDgF0ng@mail.gmail.com>
Message-ID: <54A7909F.1070308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015? 01? 02? 22:14, Ajay kumar wrote:
> Hi Daniel,
> 
> This series is sitting out there since long without any ACKs.
> If people can ACK this series, I am ready to rebase and send ASAP.

Acked-by: Inki Dae <inki.dae@samsung.com>

And, for [PATCH V8 5/14] drm/exynos: dp: support drm_bridge,
Signed-off-by: Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> 
> Regards,
> Ajay Kumar
> 
> On Fri, Jan 2, 2015 at 6:40 PM, Daniel Stone <daniel@fooishbar.org> wrote:
>> Hi Ajay,
>>
>> On 17 December 2014 at 09:31, Javier Martinez Canillas
>> <javier.martinez@collabora.co.uk> wrote:
>>>
>>> On 12/16/2014 12:37 AM, Laurent Pinchart wrote:
>>>>> You asked Ajay to change his series to use the video port and enpoints
>>>>> DT
>>>>> bindings instead of phandles, could you please review his latest
>>>>> version?
>>>>>
>>>>> I guess is now too late for 3.19 since we are in the middle of the
>>>>> merge
>>>>> window but it would be great if this series can at least made it to
>>>>> 3.20.
>>>>
>>>> I don't have time to review the series in details right now, but I'm
>>>> happy
>>>> with the DT bindings, and have no big issue with the rest of the
>>>> patches. I
>>>> don't really like the of_drm_find_bridge() concept introduced in 03/14
>>>> but I
>>>> won't nack it given lack of time to implement an alternative proposal.
>>>> It's an
>>>> internal API, it can always be reworked later anyway.
>>>
>>> Thanks a lot for taking the time to look at the DT bindings, then I guess
>>> that the series are finally ready to be merged?
>>>
>>> Ajay's series don't apply cleanly anymore because it has been a while
>>> since
>>> he posted it but he can rebase on top of 3.19-rc1 once it is released and
>>> re-resend.
>>
>>
>> Do you have any plans to rebase this so it's ready for merging?
>>
>> Thierry, Daniel, Dave - whose tree would this be best to merge through?
>>
>> Cheers,
>> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
