From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 23:06:15 +0100
Subject: [GIT PULL] ARM: meson: DTS related changes
In-Reply-To: <CAOQ7t2a9ECE8=sbvuLesUSH-EuqipjCy0qyyboase9wrRA09tw@mail.gmail.com>
References: <CAOQ7t2a9ECE8=sbvuLesUSH-EuqipjCy0qyyboase9wrRA09tw@mail.gmail.com>
Message-ID: <7900106.SaxdONAvsb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 March 2015 12:03:45 Carlo Caione wrote:
> for you to fetch changes up to b3e67c9112f6268045f78a61274fda2c7250c5c9:
> 
>   ARM: dts: meson: add DTS file for MINIX NEO-X8 (2015-03-02 11:01:03 +0100)
> 
> ----------------------------------------------------------------
> - New DTS for MINIX NEO-X8
> - Add DTS support for SPIFC, Ethernet controller and pinctrl
> 
> 

Hi Carlo,

It's not clear from your description whether these are meant for 4.0 or
4.1 at this point, so I've queued them up for 4.1 in the next/dt branch
for now.

For some reason, the tag description I got does not match the one you
have above, I've fixed that up manually.

	Arnd
