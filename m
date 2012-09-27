From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 27 Sep 2012 10:29:55 +0200
Subject: [PATCH RESEND] ARM: add dtbImage.<dt> and dtbuImage.<dt> rules
In-Reply-To: <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
References: <504DFBBF.5010202@free-electrons.com>
 <1348733441-11626-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <20120927082955.GR17667@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:10 Thu 27 Sep     , Richard Genoud wrote:
> [add Grant Likely and Rob Herring in To: since this is maybe more OF
> related than ARM related]
> 
> This rules are useful for appended device tree conforming to the
> CONFIG_ARM_APPENDED_DTB kernel option.
> 
> The rule dtbImage.<dt> is actually just a:
> cat zImage <dt>.dtb > dtbImage.<dt>
> 
> The dtbuImage.<dt> makes an uImage out of the dtbImage.<dt> file.
> 
> KernelVersion: v3.6-rc5
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
as discuss with Grant no this is a temporary solution so no Makefile Target

so nack

Best Regards,
J.
