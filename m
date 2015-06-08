From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 8 Jun 2015 15:52:06 +0900
Subject: [RESEND 1/2] usb: ehci-exynos: Make provision for vdd regulators
In-Reply-To: <CABxcv=kMi1dveFOWq6JVEAGTtZLCVHcCcWLyLZzJLaYTx0M3fw@mail.gmail.com>
References: <1433683242-3945-1-git-send-email-linux.amoon@gmail.com>
 <5574F97A.5030104@samsung.com>
 <CANAwSgTjx8uxyOTW8uuiqrcNzF+UwLMmML2OcDgG5Ku_56=vJQ@mail.gmail.com>
 <CAJKOXPfDmt5VMqr-P+OpWy1+jz675CFRPmtS_N0HjN4tWxfwtA@mail.gmail.com>
 <CABxcv=kMi1dveFOWq6JVEAGTtZLCVHcCcWLyLZzJLaYTx0M3fw@mail.gmail.com>
Message-ID: <CAJKOXPc+XKnZbDcdPgyGeaRD+wU2ef0AqiGwWjhJfCbX27c06A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-08 15:42 GMT+09:00 Javier Martinez Canillas <javier@dowhile0.org>:
> Hello,
>
> On Mon, Jun 8, 2015 at 7:14 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>
> [...]
>
>>
>> To summarize my point of view:
>> 1. Unless Vivek's says otherwise, please give him the credits with
>> proper "from" field.
>> 2. Issues mentioned in previous mail should be addressed (missing
>> IS_ERR(), how disabling the regulator during suspend affects waking
>> up).
>> 3. The patchset must be tested, even after rebasing.
>>
>
> Agreed with all the points.
>
> Anand,
>
> An easy way to preserve authorship when rebasing patches is to use the
> git command author option. As an example you can execute the following
> command:
>
> $ git commit -a -s --author='Vivek Gautam <gautam.vivek@samsung.com>'

By default "git am" and "git format-patch" preserve the author of a
patch so usually this step is not necessary. Unless the patch is
applied in a different way... :)

Best regards,
Krzysztof
