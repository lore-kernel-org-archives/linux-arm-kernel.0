From: nm@ti.com (Nishanth Menon)
Date: Sat, 3 Jan 2015 09:39:30 -0600
Subject: [PATCH V2 0/2] ARM: l2c: OMAP4/AM437x: Additional register
 programming support.\
In-Reply-To: <CA+Ln22E0_R1cXXgF_L8kdz+cTmAkhykTtN04=q6JXNsUsFv9Eg@mail.gmail.com>
References: <1420220628-23742-1-git-send-email-nm@ti.com>
 <54A6E79E.7010203@oracle.com> <54A6F5C8.2050008@ti.com>
 <20150103002317.GH3298@atomide.com>
 <CA+Ln22E0_R1cXXgF_L8kdz+cTmAkhykTtN04=q6JXNsUsFv9Eg@mail.gmail.com>
Message-ID: <20150103153930.GA26181@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:42-20150103, Tomasz Figa wrote:
> Indeed, as I figured out in the original thread about this issue,
> additional patch fixing code unaffected by my series (besides changing
> the condition which triggers calling it) is necessary. Namely, the
> affected 4 registers need to be written using the write_sec wrapper,
> instead of using writel*() directly.
> 

Agreed. Would you like to post a patch (independent) of your series to address
this - sounds like a fix that should go in independent of your original
series.

-- 
Regards,
Nishanth Menon
