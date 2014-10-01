From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 01 Oct 2014 17:18:11 +0200
Subject: [GIT PULL] arm: mediatek: Add support for mt8127 and mt8135 SoCs
In-Reply-To: <CABuKBeL9vy6fZVsDuuiWyhDvCJrFXAUUMBc12SxJODaTx8H1vA@mail.gmail.com>
References: <CABuKBeK6iUdRqTuOZyTHW-Xt3O4giXoQTJ76vkh4Mv4cA52THQ@mail.gmail.com>
 <CABuKBeL9vy6fZVsDuuiWyhDvCJrFXAUUMBc12SxJODaTx8H1vA@mail.gmail.com>
Message-ID: <2257511.iB6BnmDxPp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 September 2014 12:28:32 Matthias Brugger wrote:
> Any comments on this pull request?
> Do you want me to split the pull request in two, as there are three
> patches for next/soc and the
> remaining four for next/dt?
> 
> Please give me some feedback on this.
> 

Yes and no. In the future, I'd prefer to see split pull requests.

This time around, the pull request was late already, and I decided to
do a 'next/late' branch, which aggregates everything together, so it
does not matter. However, you should not assume that we do a branch
like this, or that Linus ends up pulling it. In case it doesn't make it
into 3.18-rc1, please send separate requests for 3.19.

	Arnd
