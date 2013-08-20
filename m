From: msalter@redhat.com (Mark Salter)
Date: Tue, 20 Aug 2013 14:04:04 -0400
Subject: [PATCH] arm64: add screen_info for console support
In-Reply-To: <20130820171453.GF21383@arm.com>
References: <1376842970.11104.11.camel@t520.redhat.com>
 <20130820133733.GF26129@mudshark.cambridge.arm.com>
 <20130820171453.GF21383@arm.com>
Message-ID: <1377021844.3591.1.camel@t520.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-08-20 at 18:14 +0100, Catalin Marinas wrote:
> I was wondering about this but do we need screen_info for DUMMY_CONSOLE
> as well?

I thought so because my grep turned up a reference to screen_info in
dummycon.c but a closer look shows that only applies to arm.

--Mark
