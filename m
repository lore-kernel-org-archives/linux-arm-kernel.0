From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Nov 2016 22:16:51 +0100
Subject: [RFC PATCH 04/11] PCI: tegra: limit to MMU build only
In-Reply-To: <65053923-c783-d8d9-d594-aa18cbed413e@wwwdotorg.org>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-5-git-send-email-vladimir.murzin@arm.com>
 <65053923-c783-d8d9-d594-aa18cbed413e@wwwdotorg.org>
Message-ID: <4182371.efWsDqfOeS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 22, 2016 9:15:13 AM CET Stephen Warren wrote:
> On 11/22/2016 02:26 AM, Vladimir Murzin wrote:
> > This driver uses functionality which available for MMU build only,
> > thus add dependency on MMU.
> 
> I'd expect ARCH_TEGRA to depend on MMU instead.
> 

Any particular reason for why we'd single out Tegra?

	Arnd
