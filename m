From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 22:57:38 +0200
Subject: [GIT PULL] STM32 defconfig changes for v4.15 #1
In-Reply-To: <8c7fe79d-ebd3-ee7c-f056-1d3aa225edee@st.com>
References: <8c7fe79d-ebd3-ee7c-f056-1d3aa225edee@st.com>
Message-ID: <CAK8P3a3sfq13v8sVox8xiXvHpSyzsvV_4LEYsoNtdfLLhyS7MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 12:16 PM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> ----------------------------------------------------------------
> STM32 defconfig updates for v4.15, round 1
>
> Highlights:
> ----------
>  -Regenerate default configuration
>  -Add DMAMUX support
>  -Add I2C F7 support
>  -Add MDMA support

Pulled into next/soc.

Splitting out the first patch is fine, but there really is no need to have one
patch per new Kconfig option you enable, it's less work and more readable to
have a combined patch that explains what the options are and why you need
all of them.

        Arnd
