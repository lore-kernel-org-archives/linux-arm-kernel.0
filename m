From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Thu, 14 Mar 2013 12:57:44 -0300
Subject: [PATCH 5/9] ARM: dts: Add GPMC node for OMAP2, OMAP4 and OMAP5
In-Reply-To: <5141F1C3.6090009@ti.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
 <1362763654-9660-6-git-send-email-jon-hunter@ti.com>
 <CABxcv==OKX4z8x7ztqDJ5CozNmTQ5UaD43mTLWfQuqUt-y7xcQ@mail.gmail.com>
 <513A5B23.5070302@ti.com>
 <CABxcv=kEi9yKRCx56dt_GRwQ7aKvrRpwCAxO6BwH4_U6jp-=JA@mail.gmail.com>
 <CALF0-+Vp-WAQo3qtmK9jSHnLC0ECg4kUnEUz_PMNtgG1nEcGvQ@mail.gmail.com>
 <513E1ADC.6030208@ti.com> <5141F07E.3030501@ti.com>
 <5141F1C3.6090009@ti.com>
Message-ID: <CALF0-+U76UpJ35hWpYGkLf5uDxfaZqcB_h-_JJdvapHSTQ0amg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 12:50 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>> Yes, I full agree with that as well. The size should be purely HW
>> related. So we should not take any assumption about the page size /
>> alignment.
>
> Ok, what is best to use? The size from hwmod structures or the size from
> the documentation?
>

My personal vote is: according to hardware documentation is the right thing,
and it's what we're doing in mvebu.

-- 
    Ezequiel
