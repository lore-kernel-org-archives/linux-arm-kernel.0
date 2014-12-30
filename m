From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Dec 2014 23:08:03 +0100
Subject: [PATCH 0/9] ARM Versatile multi-platform support
In-Reply-To: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
Message-ID: <5504415.vqcrleXQ36@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 December 2014 13:28:29 Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> This series converts ARM Versatile platform to multi-platform. I started 
> this some time ago and some pieces were already merged. The primary 
> piece remaining is converting the PCI host to DT which I was waiting for 
> the common PCI DT parsing to get settled. Now that that is in place as 
> well as a few other pieces are in place like multi-platform fixes for 
> CLCD, we can fully convert Versatile to DT and multi-platform.

Hi Rob, thanks for picking this up again, looks great overall!

I've replied to a few individual patches with minor questions, but
none of them are show-stoppers.

	Arnd
