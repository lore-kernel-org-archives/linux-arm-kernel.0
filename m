From: olof@lixom.net (Olof Johansson)
Date: Mon, 30 Sep 2013 09:29:04 -0700
Subject: [PATCH v2] arm: vexpress: tc2: fix hotplug/idle/kexec race on
 cluster power down
In-Reply-To: <alpine.LFD.2.03.1309271209450.312@syhkavp.arg>
References: <1380297282-13021-1-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.03.1309271209450.312@syhkavp.arg>
Message-ID: <20130930162904.GA5164@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 12:12:25PM -0400, Nicolas Pitre wrote:
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> ARM-SOC dudes: would you please pick this up?

I can't tell if this is actually needed for 3.12, since kexec isn't supported
without the set of patches that Dave Martin just posted.

Anyway, the fix is tiny so I applied it to the for-3.12 fixes branch anyway.


-Olof
