From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 4 Mar 2018 19:17:41 +0100
Subject: TS-x09 fails to boot when obtaining MAC
In-Reply-To: <20180304172018.c56ocfomqka4dzra@jirafa.cyrius.com>
References: <20180304172018.c56ocfomqka4dzra@jirafa.cyrius.com>
Message-ID: <20180304181741.GA21710@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2018 at 06:20:18PM +0100, Martin Michlmayr wrote:
> Several Debian users reported that Debian 9 (4.9 kernel) fails to boot
> on their QNAP TS-x09 wheras Debian 8 (3.16) works fine.  One user
> provided the following kernel log with earlyprintk.  I suspect the
> issue was introduced in 4904dbda41c860fd117b20f3c48adb2780eee37e.

Hi Martin

Please see commit

13a55372b64e00e564a08d785ca87bd9d454ba30 in DaveM's net repo. This
should make its way to stable.

       Andrew
