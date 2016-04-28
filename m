From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2016 17:56:16 +0200
Subject: [GIT PULL] Renesas ARM Based SoC DT PM Domain Updates for v4.7
In-Reply-To: <cover.1461730638.git.horms+renesas@verge.net.au>
References: <cover.1461730638.git.horms+renesas@verge.net.au>
Message-ID: <5702417.rnCUR69ruo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2016 14:20:34 Simon Horman wrote:
> Please consider these Renesas ARM based SoC DT pm-domain updates for v4.7.
> 
> This pull requests is based on a merge of:
> 
> * "[GIT PULL] Second Round of Renesas ARM Based SoC R-Car SYSC Updates for
>   v4.7", tagged as renesas-rcar-sysc2-for-v4.7, which you have already
>   pulled.
> * "[GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.7",
>   tagged as renesas-dt-for-v4.7, which you have also already pulled.
> 
> The reason for the somewhat tedious base on
> renesas-rcar-sysc2-for-v4.7, which provides driver changes,
> is a hard run-time dependency.
> 
> I also have a similar set of changes for arm64 which I will send separately.


Ok, I've started a next/late branch for this now, but unless something
else comes up that needs to be sent much later, I expect to submit
this as the last pull request at the same time as all the other ones
for 4.7.

For further clarification, am I right reading the above as meaning that
a 4.7 kernel is expected to still work with the dts files from 4.6,
but not the other way round?

	Arnd
