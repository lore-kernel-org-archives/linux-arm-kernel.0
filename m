From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 15 Feb 2017 17:16:47 +0000
Subject: [PATCH v2 0/5] ARM: add module autoloading support for crypto
 modules
In-Reply-To: <CAKv+Gu9XSjprPBHqHvTQhJ-ChXeFjVQ1K0LPNcTvru6TgUEBDA@mail.gmail.com>
References: <1484154118-22139-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9q5sH2_=3TZNbPAf3fdFB=F7Ut5swnp7qiUgwbuqemnA@mail.gmail.com>
 <CAKv+Gu9XSjprPBHqHvTQhJ-ChXeFjVQ1K0LPNcTvru6TgUEBDA@mail.gmail.com>
Message-ID: <CAKv+Gu9DFFM6LEKxs5E9jugfRj4CKHb-5nVoD4uzrjmbvk9rGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2017 at 13:47, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 19 January 2017 at 18:23, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> On 11 January 2017 at 17:01, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>> This series wires up the crypto modules that use the ARM 32-bit versions of
>>> the ARMv8 Crypto Extensions to udev autoloading, by exposing the HWCAP2
>>> feature bits via the CPU modalias. This is very similar to the arm64
>>> implementation, with the notable exception that ARM has its CPU feature
>>> definitions split across HWCAP and HWCAP2.
>>>
>>> Given that the crypto feature bits are all exposed via HWCAP2, and considering
>>> that there are currently no features exposed via HWCAP that are relevant to
>>> udev module autoloading, exposing HWCAP2 only should be sufficient, at least
>>> for now.
>>>
>>> Changes since v1:
>>> - rebase onto v4.10-rc2
>>>
>>> Ard Biesheuvel (5):
>>>   ARM: wire up HWCAP2 feature bits to the CPU modalias
>>
>> Ping?
>>
>
> Ping?

Ping?
