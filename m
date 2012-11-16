From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Nov 2012 17:42:05 +0000
Subject: [PATCH] Documentation: correct argument list for
 of_platform_populate correction to match of_platform.h prototype
In-Reply-To: <60BA5429A0E1584BA3633194F6F993B501482A65@NA-MBX-02.mgc.mentorg.com>
References: <60BA5429A0E1584BA3633194F6F993B501482A65@NA-MBX-02.mgc.mentorg.com>
Message-ID: <201211161742.06140.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 November 2012, Chaiken, Alison wrote:
> From fd4450ac6bdcf62a84b0d029b36506e7fd567688 Mon Sep 17 00:00:00 2001
> From: Alison Chaiken <alchaiken@gmail.com>
> Date: Thu, 1 Nov 2012 01:12:38 -0700
> Subject: [PATCH] Argument list for of_platform_populate correction to match of_platform.h prototype
>  
> Signed-off-by: Alison Chaiken <alison_chaiken@mentor.com>

Hi Alison,

Congratulations on your first patch on the arm mailing list!

The patch looks obviously correct to me, so

Acked-by: Arnd Bergmann <arnd@arndb.de>

Sergei already mentioned that the email was whitespace broken
and had extra lines on top, which can happen when you use 
thunderbird for sending the patch. See Documentation/email-clients.txt
for how to deal with this. My usual recommendation is to use
git-send-email.

It also helps to include all maintainers that might be responsible
for picking up the patch. In this case, there are three maintainers:
Grant Likely and Rob Herring (both doing device tree) and Rob Landley
(for Documentation). There are also two mailing lists, 
linux-doc at vger.kernel.org and devicetree-discuss at lists.ozlabs.org.

Adding all of the above to Cc increases the chances of someone
actually applying the patch. Unfortunately not all of us get to
apply patches we receive as fast as we should, and patches like
yours could get applied by any of the three people. In doubt,
you can always Cc everyone that scripts/get_maintainer.pl
suggests, but if you know the people well, you can also trim
down that list.

	Arnd
