From: vimal.newwork@gmail.com (Vimal Singh)
Date: Wed, 25 May 2011 13:18:37 +0530
Subject: Self modifying code in ARM 11 architectures
In-Reply-To: <BANLkTimyju7eEgtCpb_U6s8LNHk-_FGK4Q@mail.gmail.com>
References: <BANLkTi=mVsYiubqtJO2BmWvExMvUFRg6dg@mail.gmail.com>
	<BANLkTimyju7eEgtCpb_U6s8LNHk-_FGK4Q@mail.gmail.com>
Message-ID: <BANLkTinrj-dkJShzTQuhYSOWkK4QSEnQgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CC'ing correct ARM mailing list.

On Tue, May 24, 2011 at 3:48 PM, Ashok Babu <ashok3d@gmail.com> wrote:
> Hi All,
>
> I am no success in booting up the ARM1176 processor with the
> linux-2.6.32 kernel.
> While googling about the ARM?Harvard?architecture, I came to know that
> we have to flush/invalidate the D-Cache and I-Cache
> when using the self modifying codes.
>
> So here my questions/doubts :
> 1) Is'nt it the kernel itself is self modifying code with lots of
> function pointers ?
> ? ? If yes, how is synchronization b/w d-cache and i-cache handled in
> the kernel ?
> 2) Can this be the reason for the kernel not booting for me ?
> ? ? Because If i disable the I-Cache in the config, then the kernel
> boots up without any issues.
> Any pointers on this will be of great help.
>
> Thanks & Best Regards
> Ashok
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>



-- 
Regards,
Vimal Singh
