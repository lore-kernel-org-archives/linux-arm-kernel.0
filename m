From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 May 2013 14:04:18 +0200
Subject: build failure: linux-next: ARM defconfig: u8500
In-Reply-To: <CAGa+x84p1pVuFm_MuQVTCJq_50NTsjKtWUFAbQ0W_=beOcA55A@mail.gmail.com>
References: <CAGa+x87czosA=tWh1KRTSSqMyLckMHwNP7hrRXdokaLsSaaikA@mail.gmail.com>
 <CAGa+x84p1pVuFm_MuQVTCJq_50NTsjKtWUFAbQ0W_=beOcA55A@mail.gmail.com>
Message-ID: <CACRpkdZ1mRyhvnqaiNGQkprt_WEUdpz5+N09s3hB=GjJme73vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 1:46 AM, Kevin Hilman <khilman@linaro.org> wrote:
> On Tue, May 28, 2013 at 3:57 PM, Kevin Hilman <khilman@linaro.org> wrote:
>
>> u8500_defconfig started failing to build in linux next (next-20130527)
>> but was previously building (next-20130523.)
>
> My apologies, it appears this one is already fixed in next-20130528.
> /me updates automated build to not be a full day behind linux-next.

My fault for screwing it up one day though. :-/

This was beacuse of a double conflict in this file, and
me missing to fix the second conflict...

Linus
