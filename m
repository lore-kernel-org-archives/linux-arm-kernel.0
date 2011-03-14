From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Mar 2011 09:42:42 +0100
Subject: [PATCH 05/10] smsc911x: use shifted register access
In-Reply-To: <1299884892-6766-6-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-6-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <AANLkTikVEq6imDby9sY5uWA1r_Q0paSPOSHk7oke7ePK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 12, 2011 at 12:08 AM,  <mathieu.poirier@linaro.org> wrote:

> From: Alessandro Rubini <rubini@gnudd.com>
>
> At least one of the boards using this chip needs a shift in
> register access. This adds a "shift" field in the platform data
> to have the chip working in all cases without special ifdef.
> The approach is similaro to the one used in serial_8250 and other
> places. ?Performance-wise no difference is reported.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>

Please send this to the SMSC911x maintainer:

SMSC911x ETHERNET DRIVER
M:      Steve Glendinning <steve.glendinning@smsc.com>
L:      netdev at vger.kernel.org
S:      Supported
F:      include/linux/smsc911x.h
F:      drivers/net/smsc911x.*

Yours,
Linus Walleij
