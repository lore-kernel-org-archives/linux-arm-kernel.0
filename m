From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Mar 2010 15:54:19 -0000
Subject: [PATCH 5/6] ARM: oprofile: use perf-events framework as backend
In-Reply-To: <201002261125.04448.jpihet@mvista.com>
References: <1267124175-21721-1-git-send-email-will.deacon@arm.com>
	<201002261028.07691.jpihet@mvista.com>
	<000501cab6ca$a1ca7710$e55f6530$@deacon@arm.com>
	<201002261125.04448.jpihet@mvista.com>
Message-ID: <001401caba20$9ec4ae10$dc4e0a30$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

> I am OK to co-maintain this code if you do not mind.

Sure - the more the merrier. I'll post an updated version of the patch [using
an enum instead of #defined PMU IDs] once I've heard back from Ingo about the
symbols I'm exporting from the generic perf events code.

Will
