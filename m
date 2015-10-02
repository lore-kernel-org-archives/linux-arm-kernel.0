From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sat, 03 Oct 2015 00:34:02 +0100
Subject: Dropping "depends on SMP" for HAVE_ARM_TWD -- take 2
In-Reply-To: <560ED1FB.9010000@free.fr> (Mason's message of "Fri, 2 Oct 2015
 20:50:35 +0200")
References: <560E53E3.7070207@free.fr> <560E8584.8000207@free.fr>
 <20151002180255.GK12338@codeaurora.org> <560ED1FB.9010000@free.fr>
Message-ID: <yw1xbncgluad.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> My port requires the TWD to function. So I'm using
> select HAVE_ARM_TWD (no "if SMP") to have it work
> even on MULTIPLATFORM UP configs.

You could just let it use another timer in the non-smp case if you
didn't have that weird aversion towards using my code.

-- 
M?ns Rullg?rd
mans at mansr.com
