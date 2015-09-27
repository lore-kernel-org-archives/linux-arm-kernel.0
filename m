From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 27 Sep 2015 07:35:20 -0700
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <CAJPN1uvPyZ+hZ64_0ZXU9wPLuAR-qm06GrRmHTjc9+rgiChYDQ@mail.gmail.com>
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 <CAJPN1uvPyZ+hZ64_0ZXU9wPLuAR-qm06GrRmHTjc9+rgiChYDQ@mail.gmail.com>
Message-ID: <CAKohpo=s9A_M5FphkvmXutWNzxewCimBUv-mK75tO6nrp3-3AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 September 2015 at 22:31, Jiri Slaby <jirislaby@gmail.com> wrote:
> But this has to crash whenever the file is read as val's storage is gone at
> that moment already, right?

Yeah, its fixed now in the new version. This was a *really* bad idea :(
