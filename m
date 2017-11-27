From: liuwenliang@huawei.com (Liuwenliang (Abbott Liu))
Date: Mon, 27 Nov 2017 01:23:50 +0000
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <20171123152218.GQ31757@n2100.armlinux.org.uk>
References: <87375eqobb.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063816@dggemm510-mbs.china.huawei.com>
 <20171117073556.GB28855@cbox>
 <B8AC3E80E903784988AB3003E3E97330C00638D4@dggemm510-mbs.china.huawei.com>
 <20171118134841.3f6c9183@why.wild-wind.fr.eu.org>
 <B8AC3E80E903784988AB3003E3E97330C0068F12@dggemm510-mbx.china.huawei.com>
 <20171121122938.sydii3i36jbzi7x4@lakrids.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0069032@dggemm510-mbx.china.huawei.com>
 <757534e5-fcea-3eb4-3c8d-b8c7e709f555@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0069083@dggemm510-mbx.china.huawei.com>
 <20171123152218.GQ31757@n2100.armlinux.org.uk>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C006B4D7@dggemm510-mbs.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Nov 23, 2017  23:22  Russell King - ARM Linux [mailto:linux at armlinux.org.uk]  wrote:
>Please pay attention to the project coding style whenever creating code
>for a program.  It doesn't matter what the project coding style is, as
>long as you write your code to match the style that is already there.
>
>For the kernel, that is: tabs not spaces for indentation of code.
>You seem to be using a variable number of spaces for all the new code
>above.
>
>Some of it seems to be your email client thinking it knows better about
>white space - and such behaviours basically makes patches unapplyable.
>See Documentation/process/email-clients.rst for hints about email
>clients.
Thanks for your review.
I'm going to change it in the new version.  
