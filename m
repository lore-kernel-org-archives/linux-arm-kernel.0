From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 23 Dec 2013 17:05:08 +0100
Subject: [PATCH 2/2] ARM: Kirkwood: DT board setup for LaPlug
In-Reply-To: <CAGduivwCtQr-6sY92jEydU6uG1QJOSQcqxAKwcxr4viV38vU-Q@mail.gmail.com>
References: <1387813346-16741-1-git-send-email-maxime.hadjinlian@gmail.com>
 <1387813346-16741-2-git-send-email-maxime.hadjinlian@gmail.com>
 <CAGduivwCtQr-6sY92jEydU6uG1QJOSQcqxAKwcxr4viV38vU-Q@mail.gmail.com>
Message-ID: <20131223160508.GC7746@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 04:47:34PM +0100, Maxime Hadjinlian wrote:
> I have a slight issue which I could not resolve regarding the Hynix
> NAND on this platform. Although it worked perfectly well with 3.12,
> the device is not detected  anymore with the current head of master.
> 
> There is no warning nor bug that I could find. It just not detected.
> Since I don't really know how to debug this, maybe doing git bisect ?
> Some advice would be greatly welcomed !

Hi Maxime

git bisect sounds like the right thing to do. Once we know which patch
introduced the issue it becomes a lot easier to fix.

	   Thanks
		Andrew
