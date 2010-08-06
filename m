From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 6 Aug 2010 19:04:27 +0200
Subject: Kernel for PXA 270
In-Reply-To: <6E8DF434294A2F49BB2C8BE9F27294D987DB846B@CHN-HCLT-EVS07.HCLT.CORP.HCL.IN>
References: <6E8DF434294A2F49BB2C8BE9F27294D9858F73BA@CHN-HCLT-EVS07.HCLT.CORP.HCL.IN>
	<201007272007.42296.marek.vasut@gmail.com>
	<6E8DF434294A2F49BB2C8BE9F27294D987DB846B@CHN-HCLT-EVS07.HCLT.CORP.HCL.IN>
Message-ID: <201008061904.27633.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 6. srpna 2010 09:29:25 Unnamalai Kanchi Bashyam napsal(a):
> Dear Marek,
> 
> I am working on a custom board similar to MainstoneII (PXA270) DVK. I tried
> building the Android kernel 2.6.29 with Mainstone configuation. But it
> seems to be broken - getting many undeclared symbols in the folder
> arch/arm/mach-pxa/. The kernel that comes for MainstoneII board from
> Marvell is v2.6.14 which differs gravely with v2.6.29, for mach-pxa
> architecture.
> 

Please ALWAYS CC linux-arm-kernel mailing list. ALWAYS!

> I found that you are maintaining the linux kernel for PXA platform -
> http://www.kernel.org/pub/scm/linux/kernel/git/marex/pxa-linux-2.6.git.

You're wrong, Eric actually does (look for ycmiao tree). That tree above is 
based on Erics. You can use either anyway, the difference isn't big. But for 
development, you should use the "devel" branch.

Android kernel is probably totally fscked up, because android kernel
{\flame is a pile of crap applied on top of linux kernel (I assume google people 
will hate me here)}. You have to ask google to help you with android.

If you need help with something that's part of mainline kernel, you should 
supply information necessary to debug that problem (like the output you get).
> 
> Can you please suggest me which PXA270 development tree I can use for my
> work?
> 
> Thanks in advance for your help.
> 
> Regards,
> Unnamalai
> 
> 
> 
> DISCLAIMER:
> ---------------------------------------------------------------------------
> --------------------------------------------
> 
> The contents of this e-mail and any attachment(s) are confidential and
> intended for the named recipient(s) only. It shall not attach any
> liability on the originator or HCL or its affiliates. Any views or
> opinions presented in this email are solely those of the author and may
> not necessarily reflect the opinions of HCL or its affiliates. Any form of
> reproduction, dissemination, copying, disclosure, modification,
> distribution and / or publication of this message without the prior
> written consent of the author of this e-mail is strictly prohibited. If
> you have received this email in error please delete it and notify the
> sender immediately. Before opening any mail and attachments please check
> them for viruses and defect.
> 
> ---------------------------------------------------------------------------
> --------------------------------------------
