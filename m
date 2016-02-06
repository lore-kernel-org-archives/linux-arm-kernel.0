From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 6 Feb 2016 19:34:14 +0100
Subject: net: mv643xx: interface does not transmit after some time
In-Reply-To: <E4F9E0D0-9DA8-4E33-9F89-B49E47F11CE0@schloeter.net>
References: <E4F9E0D0-9DA8-4E33-9F89-B49E47F11CE0@schloeter.net>
Message-ID: <20160206183414.GD17218@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> How can I figure out what is wrong?

Hi Thomas

Can you find an easily way to reproduce it? iperf, or scp a big file
etc.

If you have a simple and reliable way to reproduce it, i would suggest
doing a git bisect to find out which change broke it.

      Andrew
