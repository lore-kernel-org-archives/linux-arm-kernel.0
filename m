From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 Apr 2012 14:31:11 -0700
Subject: [PATCH v9 11/25] gpio/omap: cleanup omap_gpio_mod_init function
In-Reply-To: <CAC83ZvL54bot+yQoRPPX3_9O5wfdpdBCNb4-Chw7sPyVFDBGSg@mail.gmail.com>
 (Tarun Kanti DebBarma's message of "Thu, 26 Apr 2012 10:43:57 +0530")
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
 <1328203851-20435-12-git-send-email-tarun.kanti@ti.com>
 <13629551.hP3ZV1ajDo@vclass>
 <CAC83ZvK630=6B-k2TfV3XBg8w7ZosLVDNE4ezjDYnn=hcXA48Q@mail.gmail.com>
 <CAC83ZvJDDvCu8NKTOYh75USA3fvSAKEGaXXi9PtCM955K_keSA@mail.gmail.com>
 <20120424160447.GI3739@atomide.com>
 <CAC83Zv+CCLQfZHfqMcbof6JtA-hOK1PfX5Gs0BBVQhBAiWzX_g@mail.gmail.com>
 <CAMQu2gzwijaSzXprEwTNTie3zCgFcNPonAexzrO_AWc2a8jOkw@mail.gmail.com>
 <CAC83ZvKN_Qxw-9RPfpJaL5434j0HgysZ364F+b29rdSCQWhm7A@mail.gmail.com>
 <20120425134508.GE25053@n2100.arm.linux.org.uk>
 <CAC83ZvL54bot+yQoRPPX3_9O5wfdpdBCNb4-Chw7sPyVFDBGSg@mail.gmail.com>
Message-ID: <87pqaszwtc.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Wed, Apr 25, 2012 at 7:15 PM, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

[...]

>> Correction.
>>
>> Don't email your patch in any way to the stable folk _before_ it has been
>> taken into Linus' tree. ?However, you _may_ add in the patch attributations
>> a Cc: <stable@vger.kernel.org> tag if you want the stable folk to
>> automatically pick up your patch when it _does_ end up in Linus' tree.
>> But... make sure that git send-email or whatever doesn't automatically
>> add that to the recipients for the emailed patch.
>>
>> If you send the stable people a patch before its in mainline, you'll get
>> a whinge telling you to read Documentation/stable_kernel_rules.txt
>
> Alright, I will add Cc: <stable@vger.kernel.org> tag in the patch.

If you do that, be sure to use --suppress-cc=bodycc when you send it
with git-send-email.

Kevin
