From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu,  3 May 2018 17:51:02 -0700
Subject: [PATCH] ARM: dts: BCM5301X: Relicense most DTS files to the GPL
 2.0+ / MIT
In-Reply-To: <20180502141102.31769-1-zajec5@gmail.com>
References: <20180502141102.31769-1-zajec5@gmail.com>
Message-ID: <20180504005102.20717-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  2 May 2018 16:11:02 +0200, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> These files were created and ever touched by a group of three people
> only: Dan, Hauke and me. They were licensed under GNU/GPL or ISC.
> 
> Introducing and discussing SPDX-License-Identifier resulted in a
> conclusion that ISC is a not recommended license (see also a
> license-rules.rst). Moveover an old e-mail from Alan Cox was pointed
> which explained that dual licensing is a safer solution than depending
> on a common compatibility belief.
> 
> This commit switches most of BCM5301X DTS files to dual licensing using:
> 1) GPL 2.0+ to make sure they are compatible with Linux kernel
> 2) MIT to allow sharing with more permissive projects
> Both licenses belong to the preferred ones (see LICENSES/preferred/).
> 
> An attempt to relicense remaining files will be made separately and will
> require approve from more/other developers.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---

Applied to devicetree/next, thanks!
--
Florian
