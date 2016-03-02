From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Mar 2016 23:27:48 +0100
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Fixes for v4.5
In-Reply-To: <cover.1456880499.git.horms+renesas@verge.net.au>
References: <cover.1456880499.git.horms+renesas@verge.net.au>
Message-ID: <2175554.AmiFhZ4OFM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2016 10:05:38 Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC DT fixes for v4.5.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-dt-fixes-for-v4.5,
> which you have already pulled.
> 
> If this pull-request is too late for v4.5 then please consider it for v4.6.

I've added it to both the next/dt and the fixes branch now.

At the moment it's the only bug fix we have queued up for 4.5,
if anything else comes up it will definitely be in there,
otherwise we'll decide by the end of the week.

My feeling is that we'll likely send this.
 
> HS-USB DT support was added to the porter board in v4.5-rc1.
> Unfortunately it was developed against an early revision of the
> board and newer revisions do not include the Maxim Integrated MAX3355 OTG
> chip and thus there should not be a renesas,enable-gpio property.
> 
> It is my understanding at this time that the early-revision boards in
> question have not been observed in the wild.

ok. Thanks for the detailed background info.

	Arnd
