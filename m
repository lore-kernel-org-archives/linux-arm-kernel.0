From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jun 2010 08:48:00 +0100
Subject: [PATCH] Watchdog: Adding support for ARM Primecell SP805 Watchdog
In-Reply-To: <1274344428-28329-1-git-send-email-viresh.kumar@st.com>
References: <1274344428-28329-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100602074800.GD6644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 20, 2010 at 02:03:48PM +0530, Viresh KUMAR wrote:
> Technical Reference Manual can be found at:
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0270b/DDI0270.pdf

Please include Wim Van Sebroeck for watchdog stuff - his address is in
MAINTAINERS.  Please also ensure that in future you're sending your
patches to relevant people - there isn't the capacity to review
every bit of code on this list.

There is a script - scripts/get_maintainer.pl - to help with this.
