From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 May 2014 14:55:40 +0300
Subject: [PATCH] s3cmci: port DMA code to dmaengine API
In-Reply-To: <6873175.VdOFbJiHYM@wuerfel>
References: <1400522593-6366-1-git-send-email-anarsoul@gmail.com>
 <6897537.JWQLgZ3Zsx@wuerfel>
 <CA+E=qVcqO9yaMdJABzQXiG4ikWTaB_XjT7GpD_rH6VTeBXYdKw@mail.gmail.com>
 <6873175.VdOFbJiHYM@wuerfel>
Message-ID: <CA+E=qVe0GONTbpe4E_dhg7kwUzG4QpTkxGbBQ2Z00M1B_octQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 2:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> Let's just leave channel number hardcoded, how it was before conversion.
>> It doesn't seem to be a good idea to clean non-DT machine code now, since
>> it's better to put some effort into converting s3c2410 and s3c244{0,2} to DT.
>
> Ok, fair enough.
>
> I'm actually more interested in making s3c24xx multiplatform capable than
> moving it to DT, but we that requires a few other patches as well, and
> we can fix this one along with those.

Hm, but s3c2410, s3c2440 and s3c2442 are armv4t. Is it possible at all
to make them multiplatform?

Regards
Vasily

>         Arnd
