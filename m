From: cjb@laptop.org (Chris Ball)
Date: Wed, 01 Jun 2011 13:00:02 -0400
Subject: [PATCH v2 0/2] sdio: add quirk for spurious SDIO IRQ
In-Reply-To: <alpine.LFD.2.00.1106011157000.30544@xanadu.home> (Nicolas
	Pitre's message of "Wed, 1 Jun 2011 11:59:25 -0400 (EDT)")
References: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
	<alpine.LFD.2.00.1106011157000.30544@xanadu.home>
Message-ID: <m3hb894hd9.fsf@pullcord.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 01 2011, Nicolas Pitre wrote:
>> This patchset adds a quirk to support this spurious IRQ issue and also report
>> a warning if an SDIO interrupt is raised but none CCCR_INTx bits are set.
>
> Given that the issue can be fixed locally to the libertas driver, I'd 
> suggest not merging this series until truly unfixable issues come up, as 
> Daniel said.

Yep, agreed.  Dan, please go ahead and submit the libertas patch and
let us know if there are any problems getting it in for 3.0.  (Ideally
by the next -rc!)

Thanks very much, everyone,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
