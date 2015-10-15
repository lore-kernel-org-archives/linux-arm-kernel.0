From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 15 Oct 2015 12:23:05 -0500
Subject: [PATCH v2] ARM: fix vdsomunge not to depend on glibc specific
 byteswap.h
In-Reply-To: <585048FA-B498-4F84-AC09-642D95D7E8D9@goldelico.com>
References: <2039A9BE-ADA4-4D28-84F4-C8B9D76834AD@goldelico.com>
 <B69CCAC6-FB47-4B2B-95F9-15F1BA4AD381@goldelico.com>
 <5B19AAFC-976C-4B33-A83E-229693FA7858@goldelico.com>
 <561E63C9.3040702@mentor.com>
 <350DE2A3-622F-4624-8AFC-D0F37CCB29EA@goldelico.com>
 <561FDD58.1020602@mentor.com>
 <585048FA-B498-4F84-AC09-642D95D7E8D9@goldelico.com>
Message-ID: <561FE0F9.8010201@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 12:16 PM, H. Nikolaus Schaller wrote:
> Does this mean it is ok now in V3 in all cases? I have switched my patch editor
> tool from indirect git imap-send to git send-email (which appears to be more
> compatible).

v3 applied without issue, so yes, in that respect it is fine.
