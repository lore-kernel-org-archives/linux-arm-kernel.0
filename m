From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 8 Jun 2015 08:42:52 +0200
Subject: [RESEND 1/2] usb: ehci-exynos: Make provision for vdd regulators
In-Reply-To: <CAJKOXPfDmt5VMqr-P+OpWy1+jz675CFRPmtS_N0HjN4tWxfwtA@mail.gmail.com>
References: <1433683242-3945-1-git-send-email-linux.amoon@gmail.com>
 <5574F97A.5030104@samsung.com>
 <CANAwSgTjx8uxyOTW8uuiqrcNzF+UwLMmML2OcDgG5Ku_56=vJQ@mail.gmail.com>
 <CAJKOXPfDmt5VMqr-P+OpWy1+jz675CFRPmtS_N0HjN4tWxfwtA@mail.gmail.com>
Message-ID: <CABxcv=kMi1dveFOWq6JVEAGTtZLCVHcCcWLyLZzJLaYTx0M3fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Jun 8, 2015 at 7:14 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:

[...]

>
> To summarize my point of view:
> 1. Unless Vivek's says otherwise, please give him the credits with
> proper "from" field.
> 2. Issues mentioned in previous mail should be addressed (missing
> IS_ERR(), how disabling the regulator during suspend affects waking
> up).
> 3. The patchset must be tested, even after rebasing.
>

Agreed with all the points.

Anand,

An easy way to preserve authorship when rebasing patches is to use the
git command author option. As an example you can execute the following
command:

$ git commit -a -s --author='Vivek Gautam <gautam.vivek@samsung.com>'

> Best regards,
> Krzysztof

Best regards,
Javier
