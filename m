From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Jan 2011 09:39:40 +0000
Subject: [PATCH 1/2] stackprotector: add stack smashing protector
	generic implementation
In-Reply-To: <4D245D16.5010702@st.com>
References: <1293111851-7175-1-git-send-email-filippo.arcidiacono@st.com>
	<4D245D16.5010702@st.com>
Message-ID: <20110106093940.GA31708@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 12:59:18PM +0100, Carmelo AMOROSO wrote:
> Is someone interested into this stuff ?

Looking at the CC list, you're asking the people who already have the
support in the kernel.  I suspect they don't have that much of an
interest in it.

Maybe you should try asking other architecture maintainers who don't
support this yet?  Not every architecture maintainer is subscribed to,
or reads LKML...
