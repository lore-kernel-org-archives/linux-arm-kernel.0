From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Jun 2016 22:51:43 -0700
Subject: [GIT PULL 5/7] Broadcom maintainers changes for 4.8 Part 1
In-Reply-To: <1466128575-5378-5-git-send-email-f.fainelli@gmail.com>
References: <1466128575-5378-1-git-send-email-f.fainelli@gmail.com>
 <1466128575-5378-5-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160620055143.GH2329@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2016 at 06:56:13PM -0700, Florian Fainelli wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.8/maintainers
> 
> for you to fetch changes up to f6d925c8f8bb2e01c16dd5cd0e3d773beb84554d:
> 
>   MAINTAINERS: Update entry for BCM5301X ARM (2016-06-10 11:30:24 -0700)
> 
> ----------------------------------------------------------------
> This pull request contains MAINTAINERS file updates for Broadcom SoCs:
> 
> - Rafal updates the BCM5301x entry wih the typical Broadcom mailing-list
> 
> ----------------------------------------------------------------
> Rafa?? Mi??ecki (1):
>       MAINTAINERS: Update entry for BCM5301X ARM

Is bcm-kernel-feedback-list at broadcom.com a list that the public can subscribe
to, or is it an internal list that the team is on?

If it's the latter then it shouldn't be a mailing list in the maintainers
file. There's a dual purpose to the L: entries -- one is where to cc the
patches to, the other is what list to figure out how to subscribe to if you
care about patches for that platform...


Not merged until the above is clarified.


-Olof
