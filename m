From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Fri, 5 Jul 2013 13:48:44 +0200
Subject: [PATCH v5] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <alpine.DEB.2.02.1307051213080.11637@ionos.tec.linutronix.de>
References: <1372687359-18235-1-git-send-email-jonas.jensen@gmail.com>
 <1372940383-5957-1-git-send-email-jonas.jensen@gmail.com>
 <alpine.DEB.2.02.1307042211420.11637@ionos.tec.linutronix.de>
 <CACmBeS03Xfo7DyyYUbpBaO8TeR3g8BTPzcoOzQayk40k1soFzA@mail.gmail.com>
 <alpine.DEB.2.02.1307051213080.11637@ionos.tec.linutronix.de>
Message-ID: <CACmBeS1djCBWeXwCQROtvyodCfunusr-3=CKOk294P+FF-h6wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the replies Thomas.

On 5 July 2013 12:21, Thomas Gleixner <tglx@linutronix.de> wrote:
> Because you need to preserve the CR2 enable bit so your clocksource
> does not get switched off.

Yes, that was my main concern. The possibility of more flags being added.
I was experimenting with TIMEREG_CR_COUNT_UP but could never get REG_MATCH1
to work right for oneshot mode.

Please take a look at v7.

Best regards,
Jonas
