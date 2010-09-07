From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 7 Sep 2010 14:46:19 +0530
Subject: [PATCH 13/74] ST SPEAr: Update clock framework and definitions
In-Reply-To: <20100907090908.GA9978@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<a15d1fca5a6e663c1fee4602013b6160512eb2dd.1283161023.git.viresh.kumar@st.com>
	<20100906230931.GF8153@game.jcrosoft.org> <4C85B868.6040908@st.com>
	<20100907040641.GA30509@game.jcrosoft.org>
	<4C85FF6A.5060904@st.com>
	<20100907090908.GA9978@n2100.arm.linux.org.uk>
Message-ID: <4C8602E3.2030203@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/7/2010 2:39 PM, Russell King - ARM Linux wrote:
> I'd suggest leaving it as is - presumably its already been tested and
> so works.
> 
> Adding that macro just encourages bad usage anyway - by encouraging
> people to name individual clocks by their source rather than by their
> consumer.  Naming clocks by their source has been proven many times to
> make things more complicated and difficult in the long run.

OK.

thanks
viresh.
