From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 13 May 2012 01:06:27 +0200
Subject: [PATCH] ARM: integrator: fix typo in PCI swizzle function
In-Reply-To: <20120512094003.GA10453@n2100.arm.linux.org.uk>
References: <1336813546-25766-1-git-send-email-linus.walleij@linaro.org>
 <20120512094003.GA10453@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdY0-kN=--j8TMBj7zWq7zD+1vYzq_sEHm-3Pg2FctomEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2012 at 11:40 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, May 12, 2012 at 11:05:46AM +0200, Linus Walleij wrote:
>> The next tree didn't compile due to a typo in commit
>> cfb32a689949d09f112493de4a1e3e5900db2053
>> "ARM: PCI: integrator: use common PCI swizzle"
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Do you want me to merge this into the original commit?

Why not, do you need it in the patch tracker or will you
just hand-edit it?

Thanks,
Linus Walleij
