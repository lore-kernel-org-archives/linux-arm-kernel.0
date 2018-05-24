From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 24 May 2018 22:34:49 +0300
Subject: uImage target support on arm64
In-Reply-To: <CA+Kvs9=mgW4Z=UcBZZLL82fJ=c--OXF3=B2Zbho+CfMTr8Wk-Q@mail.gmail.com>
References: <CA+Kvs9=mgW4Z=UcBZZLL82fJ=c--OXF3=B2Zbho+CfMTr8Wk-Q@mail.gmail.com>
Message-ID: <20180524193449.jql27apudwaevwpf@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ramon,

On Thu, May 24, 2018 at 10:05:15PM +0300, Ramon Fried wrote:
> I've noticed that it's not supported.
> Is it on purpose ?

Yes. The 32bit load address in the uImage header in pretty limited when 
applied to 64bit ARM64. Even for ARM zImage is the preferred kernel format for 
quite some time now, since it allows flexible load address, as well as 
multi-platform kernels.

> If not I'll be happy to add support for: make uImage
> for arm64 targets.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
