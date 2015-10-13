From: info@lategoodbye.de (Stefan Wahren)
Date: Tue, 13 Oct 2015 21:01:34 +0200
Subject: [PATCH v3 3/7] drm/vc4: Add KMS support for Raspberry Pi.
In-Reply-To: <561D5276.40906@lategoodbye.de>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
 <1444426068-15817-4-git-send-email-eric@anholt.net>
 <561A6BE4.9080409@lategoodbye.de> <87io6a3a34.fsf@eliezer.anholt.net>
 <561D5276.40906@lategoodbye.de>
Message-ID: <561D550E.6090303@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 13.10.2015 um 20:50 schrieb Stefan Wahren:
> Am 13.10.2015 um 20:19 schrieb Eric Anholt:
>> Stefan Wahren <info@lategoodbye.de> writes:
>>
>>>> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
>>>> new file mode 100644
>>>> index 0000000..e810ef7
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/vc4/Kconfig
>>>> @@ -0,0 +1,13 @@
>>>> +config DRM_VC4
>>>> +    tristate "Broadcom VC4 Graphics"
>>>> +    depends on ARCH_BCM2835
>>>
>>> depends on (ARCH_BCM2835 || COMPILE_TEST) ?
>>
>> Done.
>
> Sorry for the bad suggestion. The parentheses should be necessary.

The parentheses aren't necessary.

Sorry for the noise

Stefan
