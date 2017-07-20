From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Thu, 20 Jul 2017 18:46:04 +0300
Subject: [Patch v5 12/12] Documention: v4l: Documentation for HEVC CIDs
In-Reply-To: <1500290336.16819.6.camel@smitha-fedora>
References: <1497849055-26583-1-git-send-email-smitha.t@samsung.com>
 <CGME20170619052521epcas5p36a0bc384d10809dcfe775e6da87ed37b@epcas5p3.samsung.com>
 <1497849055-26583-13-git-send-email-smitha.t@samsung.com>
 <617cb1c5-074c-3f47-0096-fe7568dab8be@linaro.org>
 <1500290336.16819.6.camel@smitha-fedora>
Message-ID: <54ad8901-ccd0-4b0b-bb3f-23779d3534e8@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>>> +
>>> +    * - ``V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN``
>>> +      - Main profile.
>>
>> MAIN10?
>>
> No just MAIN.

I haven't because the MFC does not supported it?

If so, I think we have to add MAIN10 for completeness and because other
drivers could have support for it.

-- 
regards,
Stan
