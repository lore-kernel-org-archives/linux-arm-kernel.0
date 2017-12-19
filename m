From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Mon, 18 Dec 2017 20:52:53 -0800
Subject: [PATCH] drivers: gpio: remove duplicate includes
In-Reply-To: <1513429012-8327-1-git-send-email-pravin.shedge4linux@gmail.com>
References: <1513429012-8327-1-git-send-email-pravin.shedge4linux@gmail.com>
Message-ID: <CADtm3G5L61_P36xSz=_ADN=vr48wAe9CxSROKicwTjFge3-y4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 16, 2017 at 4:56 AM, Pravin Shedge
<pravin.shedge4linux@gmail.com> wrote:
> These duplicate includes have been found with scripts/checkincludes.pl
> but they have been removed manually to avoid removing false positives.
>
> Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
