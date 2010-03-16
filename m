From: jassisinghbrar@gmail.com (jassi brar)
Date: Tue, 16 Mar 2010 11:01:13 +0900
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <20100315131540.GD700@n2100.arm.linux.org.uk>
References: <4B9DB823.1040809@st.com>
	<1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>
	<4B9DC239.90407@st.com>
	<1b68c6791003142241q274b573dl3e60bf25be462e68@mail.gmail.com>
	<4B9DD46E.7060704@st.com>
	<20100315131540.GD700@n2100.arm.linux.org.uk>
Message-ID: <1b68c6791003151901w219cb016xd5b2513e2357d632@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 10:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Mar 15, 2010 at 12:02:14PM +0530, Viresh KUMAR wrote:
> That means if you leave the configuration of pins to modular drivers,
> pins are left unconfigured, and you could have some of them floating
> increasing your power consumption.
Thanks for the invaluable insight.
Sometimes, I wish there was some mechanism to automatically
compile such advices, from experts in long and numerous
threads of discussion, into some checklist/faq for developers.
