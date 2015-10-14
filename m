From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 14:36:21 +0200
Subject: [PATCH 0/4] ARM: berlin: improve multi_v7_defconfig support
In-Reply-To: <1444818844-2865-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1444818844-2865-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <6303906.JnZ5PeFoqZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 12:34:00 Antoine Tenart wrote:
> Hi all,
> 
> Some drivers used on a Marvell Berlin kernel were missing from
> multi_v7_defconfig. This series add them.

Adding them is great, but we try to have as much as possible
in loadable modules for new additions. Can you do this?

Having a single patch instead of four different ones is fine too,
by the way.

	Arnd
