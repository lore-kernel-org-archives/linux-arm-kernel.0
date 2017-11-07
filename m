From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 7 Nov 2017 09:01:34 +0900
Subject: [PATCH v4] arm64: support __int128 on gcc 5+
In-Reply-To: <CAKv+Gu94w3f0n4qDeR3uC5nVaKwjTUYf8W4cs5L3nE1HxoDG9Q@mail.gmail.com>
References: <20171103141858.13149-1-Jason@zx2c4.com>
 <20171106093151.8312-1-Jason@zx2c4.com>
 <20171106155917.glgjgipppzsdpp6h@armageddon.cambridge.arm.com>
 <20171106161459.bm4b2c7ahljluuda@armageddon.cambridge.arm.com>
 <CAHmME9p+ef-+fmdiO15LU7X3Sr-CDyngpPwKZN2FqOQmZNjLtg@mail.gmail.com>
 <CAKv+Gu94w3f0n4qDeR3uC5nVaKwjTUYf8W4cs5L3nE1HxoDG9Q@mail.gmail.com>
Message-ID: <CAHmME9o7_g=_yofAMBaABrPzbVrKryv9ucb=MhAB6CGC6g=4tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 7, 2017 at 1:55 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> It appears your v4 adds __ashlti3() and __ashrti3, whereas the error
> is about __lshrti3() being undefined.

Whoopsie. v5 adds the final missing function. Looks like it now
compiles for -next with the config you provided me.
