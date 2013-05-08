From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 May 2013 20:55:30 +0200
Subject: [RFC 5/8] ARM:stih41x: Add STiH415 SOC support
In-Reply-To: <A3BF01DB4A606149A4C20C4C4C808F6C3189E576E2@SAFEX1MAIL1.st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081818.01927.arnd@arndb.de>
 <A3BF01DB4A606149A4C20C4C4C808F6C3189E576E2@SAFEX1MAIL1.st.com>
Message-ID: <201305082055.31081.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 May 2013, Stephen GALLIMORE wrote:

> If you have a better solution, or a way to generalize this that would
> make sense for the ARM architecture as a whole, then we are more than
> happy to change.

No idea, sorry. Upon closer inspection I wonder if your code actually
does anything to the hardware that causes it to wake up on an interrupt.

	Arnd
