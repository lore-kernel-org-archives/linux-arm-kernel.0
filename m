From: prasannatsmkumar@gmail.com (PrasannaKumar Muralidharan)
Date: Sun, 28 May 2017 11:09:43 +0530
Subject: [PATCH v6 4/5] crypto: inside-secure: add SafeXcel EIP197 crypto
 engine driver
In-Reply-To: <20170524141035.21031-5-antoine.tenart@free-electrons.com>
References: <20170524141035.21031-1-antoine.tenart@free-electrons.com>
 <20170524141035.21031-5-antoine.tenart@free-electrons.com>
Message-ID: <CANc+2y46roki41fd_yURACWeXNzjyBEk_kOwiLEr_D=zFyaWuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antonie,

On 24 May 2017 at 19:40, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:
> Add support for Inside Secure SafeXcel EIP197 cryptographic engine,
> which can be found on Marvell Armada 7k and 8k boards. This driver
> currently implements: ecb(aes), cbc(aes), sha1, sha224, sha256 and
> hmac(sah1) algorithms.
>
> Two firmwares are needed for this engine to work. Their are mostly used
> for more advanced operations than the ones supported (as of now), but we
> still need them to pass the data to the internal cryptographic engine.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

As you have got help from other people for testing, wouldn't it be
nice to add tested-by tag?

Regards,
PrasannaKumar
